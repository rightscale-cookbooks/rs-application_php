require 'spec_helper'

apache_name = ''
php_packages = []
case os[:family]
when 'debian', 'ubuntu'
  apache_name = 'apache2'
  php_packages = %w(php5 php5-cgi php5-dev php5-cli php-pear)
  collectd_plugin_dir = '/etc/collectd/plugins'
when 'redhat'
  apache_name = 'httpd'
  php_packages = %w(php php-devel php-cli php-pear)
  collectd_plugin_dir = '/etc/collectd.d'
end

describe 'Required packages are installed' do
  # The package specified in rs-application_php/packages is installed
  describe package('sl') do
    it { should be_installed }
  end

  # The package 'git' should be installed by the git::default recipe
  describe package('git') do
    it { should be_installed }
  end

  describe 'PHP packages are installed' do
    php_packages.each do |php_package|
      describe package(php_package) do
        it { should be_installed }
      end
    end
  end

  describe package(apache_name) do
    it { should be_installed }
  end
end

describe service(apache_name) do
  it { should be_enabled }
  it { should be_running }
end

describe port(8080) do
  it { should be_listening }
end

describe command('curl --silent --location http://localhost:8080') do
  its(:stdout) { should match /Basic html serving succeeded/ }
end

describe command('curl --silent --location http://localhost:8080/appserver') do
  its(:stdout) { should match /PHP configuration=succeeded/ }
end

describe file('/usr/local/www/sites/example/migration') do
  it { should contain 'migration is being performed' }
end

describe 'apache status module' do
  describe file("/etc/#{apache_name}/mods-available/status.conf") do
    it { should be_file }
    its(:content) { should match /^\s*ExtendedStatus On/ }
  end

  describe file("/etc/#{apache_name}/mods-enabled/status.conf") do
    it { should be_linked_to '../mods-available/status.conf' }
  end
end

describe 'application server tags' do
  hostname = `hostname -s`.chomp
  tag_file = "/vagrant/cache_dir/machine_tag_cache/#{hostname}/tags.json"

  describe file(tag_file) do
    it { should be_file }

    it "should have the application server tags" do
      tags_json = JSON.load(IO.read(tag_file))

      expect(tags_json).to include("application:active=true")
      expect(tags_json).to include("application:active_example=true")
      expect(tags_json).to include("application:bind_ip_address_example=33.33.33.10")
      expect(tags_json).to include("application:bind_port_example=8080")
      expect(tags_json).to include("application:vhost_path_example=www.example.com")
    end
  end
end

describe 'apache collectd plugin' do
  describe command('curl --silent http://localhost:8080/server-status?auto') do
    its(:stdout) { should match(/Scoreboard: /) }
  end

  describe file("#{collectd_plugin_dir}/apache.conf") do
    it { should be_file }
    its(:content) { should match /^\s*LoadPlugin "apache"/ }
    it { should contain("URL \"http://localhost:8080/server-status?auto\"").from("<Plugin \"apache\">").to("</Plugin>") }
  end
end

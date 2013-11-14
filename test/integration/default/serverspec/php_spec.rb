require 'spec_helper'

apache_name = ''
case backend.check_os
when 'Debian'
  apache_name = 'apache2'
when 'RedHat'
  apache_name = 'httpd'
end

describe 'Required packages are installed' do
  describe package('git') do
    it { should be_installed }
  end

  php_packages = []
  case backend.check_os
  when 'Debian'
    php_packages = %w(php5 php5-cgi php5-dev php5-cli php-pear)
  when 'RedHat'
    php_packages = %w(php php-devel php-cli php-pear)
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

describe command('curl --silent --location localhost:8080') do
  it { should return_stdout /Basic html serving succeeded/ }
end

describe command('curl --silent --location localhost:8080/appserver') do
  it { should return_stdout /PHP configuration=succeeded/ }
end

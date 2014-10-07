require 'spec_helper'

mysql_service_name = ''
case os[:family]
when 'debian'
  mysql_service_name = 'mysql'
when 'redhat'
  mysql_service_name = 'mysqld'
end

describe 'Required packages are installed' do

  php_mysql_packages = []
  case os[:family]
  when 'debian'
    php_mysql_packages = %w(mysql-client libmysqlclient-dev php5-mysql)
  when 'redhat'
    php_mysql_packages = %w(mysql mysql-devel php-mysql)
  end

  describe 'Mysql client packages for PHP are installed' do
    php_mysql_packages.each do |mysql_package|
      describe package(mysql_package) do
        it { should be_installed }
      end
    end
  end
end

describe package('mysql') do
  let(:path) { '/opt/chef/embedded/bin' }
  it { should be_installed.by('gem') }
end

describe 'Database configuration file is created with correct settings' do
  describe file('/usr/local/www/sites/example/shared/db.php') do
    it { should be_file }
    it { should contain '$hostname_DB = "localhost";' }
    it { should contain '$username_DB = "app_user";' }
    it { should contain '$password_DB = "apppass";' }
    it { should contain '$database_DB = "app_test";' }
  end
  describe file('/usr/local/www/sites/example/current/config/db.php') do
    it { should be_linked_to '/usr/local/www/sites/example/shared/db.php' }
  end
end


describe service(mysql_service_name) do
  it { should be_enabled }
  it { should be_running }
end

describe command('curl --silent --location http://localhost:8080/dbread') do
  its(:stdout) { should match /I am in the db/ }
end

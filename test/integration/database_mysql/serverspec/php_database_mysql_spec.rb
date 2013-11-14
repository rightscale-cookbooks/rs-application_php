require 'spec_helper'

mysql_service_name = ''
case backend.check_os
when 'Debian'
  mysql_service_name = 'mysql'
when 'RedHat'
  mysql_service_name = 'mysqld'
end

describe 'Required packages are installed' do

  php_mysql_packages = []
  case backend.check_os
  when 'Debian'
    php_mysql_packages = %w(mysql-client libmysqlclient-dev php5-mysql)
  when 'RedHat'
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

# TODO: serverspec currently doesn't support specifying the location of the gem command
# So this test will only work if the gem command is in path.
#
#describe package('mysql') do
#  let(:path) { '/opt/chef/embedded/bin' }
#  it { should be_installed.by('gem') }
#end

describe 'Database configuration file is created' do
  describe file('/usr/local/www/sites/example/shared/db.php') do
    it { should be_file }
  end
  describe file('/usr/local/www/sites/example/current/config/db.php') do
    it { should be_linked_to '/usr/local/www/sites/example/shared/db.php' }
  end
end


describe service(mysql_service_name) do
  it { should be_enabled }
  it { should be_running }
end
# The bats test was
# @test 'php application connects to the database' {
#   curl --silent --location localhost:8080/dbread | grep --only-matching 'I am in the db' | wc --lines | grep 3
# }
#
describe command('curl --silent --location localhost:8080/dbread') do
  it { should return_stdout /I am in the db/ }
end

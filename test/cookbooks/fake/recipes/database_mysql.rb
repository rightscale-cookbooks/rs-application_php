# frozen_string_literal: true
#
# Cookbook Name:: fake
# Recipe:: database_mysql
#
# Copyright (C) 2014 RightScale, Inc.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#    http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#
node.default['mysql']['server_root_password'] = 'rootpass'
include_recipe 'yum-mysql-community::mysql55' if node['platform_family'] == 'rhel' && node['platform_version'].split('.').first == '7'

mysql2_chef_gem 'default' do
  provider Chef::Provider::Mysql2ChefGem::Mysql
  action :install
end

# The connection hash to use to connect to mysql
mysql_connection_info = {
  host: 'localhost',
  username: 'root',
  socket: '/var/run/mysql-default/mysqld.sock',
  password: 'rootpass',
}

mysql_service 'default' do
  port '3306'
  initial_root_password 'rootpass'
  action [:create, :start]
end

# Create the test database
mysql_database node['fake']['database_name'] do
  connection mysql_connection_info
  action :create
end

# Create the application user
mysql_database_user node['fake']['app_user'] do
  connection mysql_connection_info
  password   node['fake']['app_password']
  database_name node['fake']['database_name']
  host 'localhost'
  privileges [:select, :update, :insert]
  action     [:create, :grant]
end

# Obtain the mysql dump file
cookbook_file '/tmp/mysql.dump' do
  source 'mysql.dump'
end

# Import the mysql dump
execute 'import mysql dump' do
  command "cat /tmp/mysql.dump | mysql --user=root -b #{node['fake']['database_name']}" \
          ' --password=rootpass --socket=/var/run/mysql-default/mysqld.sock'
end

cookbook_file '/etc/my.cnf' do
  source 'my.cnf'
  owner 'root'
  group 'root'
  mode '0644'
  action :create
  notifies :create, 'cookbook_file[ini]', :delayed
end

if node['platform_family'] == 'rhel'
  php_ini_file = '/etc/php.d/app-mysql.ini'
  php_apache_location = '/etc/php.d/app-mysql2.ini'
elsif node['platform_family'] == 'debian'
  case node['platform_version']
  when '12.04'
    php_ini_file = '/etc/php5/conf.d/app-mysql.ini'
    php_apache_location = '/etc/php5/apache2/app-mysql.ini'
  when '14.04'
    php_ini_file = '/etc/php5/mods-available/app-mysql.ini'
    php_apache_location = '/etc/php5/apache2/conf.d/app-mysql.ini'
  end
end

cookbook_file 'ini' do
  path php_ini_file
  source 'mysql.ini'
  owner 'root'
  group 'root'
  mode '0644'
  action :nothing
  notifies :create, "link[#{php_apache_location}]", :delayed unless node['platform_family'] == 'rhel'
end

service 'apache2' do
  action :nothing
end

link php_apache_location do
  to php_ini_file
  link_type :symbolic
  action :nothing
  notifies :restart, 'service[apache2]', :delayed
end

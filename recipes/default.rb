#
# Cookbook Name:: rs-application_php
# Recipe:: default
#
# Copyright (C) 2013 RightScale, Inc.
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

#case node['rs-app']['database']
#when 'postgresql'
#  database_module = 'pgsql'
#else
#  database_module = node['rs-app']['database']
#end

#include_recipe "php::module_#{database_module}"

node.set['apache']['listen_ports'] = [node['rs-app']['listen_port']]

application node['rs-app']['application_name'] do
  path "/usr/local/www/sites/#{node['rs-app']['application_name']}"
  owner node['apache']['user']
  group node['apache']['group']

  repository node['rs-scm']['repository']
  revision node['rs-scm']['revision']
  scm_provider node['rs-scm']['provider']

  packages node['rs-st-php']['packages']

  # migration
  if node['rs-app']['migration_command'] && !node['rs-app']['migration_command'].empty?
    migrate true
    migration_command node['rs-app']['migration_command']
  end

  # TODO: change behavior of the before_deploy callback in the application
  # cookbook to be consistent with the behavior of the callbacks from the Chef
  # deploy resource
  if node['rs-app']['before_deploy'] && !node['rs-app']['before_deploy'].empty?
    before_deploy node['rs-app']['before_deploy']
  end

  if node['rs-app']['before_migrate'] && !node['rs-app']['before_migrate'].empty?
    before_migrate node['rs-app']['before_migrate']
  end

  if node['rs-app']['before_symlink'] && !node['rs-app']['before_symlink'].empty?
    before_symlink node['rs-app']['before_symlink']
  end

  if node['rs-app']['before_restart'] && !node['rs-app']['before_restart'].empty?
    before_restart node['rs-app']['before_restart']
  end

  if node['rs-app']['after_restart'] && !node['rs-app']['after_restart'].empty?
    after_restart node['rs-app']['after_restart']
  end

  php node['rs-app']['application_name'] do
    # database configuration
    write_settings_file true
    local_settings_file 'config/db.php'
    settings_template 'db.php.erb'

    database do
      host 'localhost'
      user 'appuser'
      password 'apppass'
      schema 'app_test'
    end
  end

  mod_php_apache2
end

#include_recipe 'rs-app'

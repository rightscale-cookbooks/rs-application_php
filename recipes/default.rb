# frozen_string_literal: true
#
# Cookbook Name:: rs-application_php
# Recipe:: default
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

include_recipe 'git'
include_recipe 'apt'
include_recipe 'yum-epel'
include_recipe 'yum-ius' if node['platform_family'] == 'rhel'

include_recipe 'yum-mysql-community::mysql57' if node['platform_family'] == 'rhel'

mysql_client 'default' do
  action :create
end

mysql2_chef_gem 'default' do
  action :install
end

unless node['rs-application_php']['packages'].nil?
  node.override['php']['packages'] = node['rs-application_php']['packages'].select { |s| s.match(/php/) } unless
    node['rs-application_php']['packages'].select { |s| s.match(/php/) }.count == 0
  node.override['php']['mysql']['package'] = node['rs-application_php']['packages'].select { |s| s.match(/mysql/) } unless
     node['rs-application_php']['packages'].select { |s| s.match(/mysql/) }.count == 0
end

include_recipe 'php::module_mysql'

# Validate application name
RsApplicationPhp::Helper.validate_application_name(node['rs-application_php']['application_name'])
application_name = node['rs-application_php']['application_name']

# Convert the packages list to a Hash if any of the package has version specified.
# See libraries/helper.php for the definition of `split_by_package_name_and_version` method.
application_packages = RsApplicationPhp::Helper.split_by_package_name_and_version(node['rs-application_php']['packages'])

# TODO: The database block in the php block below doesn't accept node variables.
# It is a known issue and will be fixed by Opscode.
#
database_host = node['rs-application_php']['database']['host']
database_user = node['rs-application_php']['database']['user']
database_password = node['rs-application_php']['database']['password']
database_schema = node['rs-application_php']['database']['schema']
listen_port = node['rs-application_php']['listen_port']

node.override['apache']['listen'] = ["*:#{listen_port}"]

# Enable Apache extended status page
Chef::Log.info "Overriding 'apache/ext_status' to true"
node.override['apache']['ext_status'] = true

# Setting up vhost alias list
vhost_aliases = ['localhost', 'localhost.localdomain', "*.#{application_name}", "#{application_name}.#{node['domain']}", node['fqdn']]
vhost_aliases << node['cloud']['public_hostname'] if node.key?('cloud')

Chef::Log.info "web_app overrides(server_port:#{listen_port},allow_override:#{node['rs-application_php']['allow_override']}"
overrides = {
  server_port: listen_port,
  allow_override: node['rs-application_php']['allow_override'],
}

# Set up application
application application_name do
  path "/usr/local/www/sites/#{application_name}"
  owner node['apache']['user']
  group node['apache']['group']

  # Configure SCM to check out application from
  repository node['rs-application_php']['scm']['repository']
  revision node['rs-application_php']['scm']['revision']
  scm_provider node['rs-application_php']['scm']['provider']
  shallow_clone false
  if node['rs-application_php']['scm']['deploy_key'] && !node['rs-application_php']['scm']['deploy_key'].empty?
    deploy_key node['rs-application_php']['scm']['deploy_key']
  end

  # Install application related packages
  packages application_packages

  # Application migration step
  if node['rs-application_php']['migration_command'] && !node['rs-application_php']['migration_command'].empty?
    migrate true
    migration_command node['rs-application_php']['migration_command']
  end

  # Configure PHP
  php node['rs-application_php']['application_name'] do
    app_root node['rs-application_php']['app_root']
    write_settings_file node['rs-application_php']['write_settings_file'] == true ||
                        node['rs-application_php']['write_settings_file'] == 'true'
    local_settings_file node['rs-application_php']['local_settings_file']
    settings_template node['rs-application_php']['settings_template']

    # Database configuration
    database do
      host database_host
      user database_user
      password database_password
      schema database_schema
    end
  end

  # Configure Apache and mod_php to run application by creating virtual host
  mod_php_apache2 do
    server_aliases vhost_aliases
    webapp_overrides overrides
  end
end

#
# Cookbook Name:: rs-application_php
# Attribute:: default
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

# Packages to install
default['rs-application_php']['packages'] = []

# Application listen port
default['rs-application_php']['listen_port'] = 8080

# Application bind IP type - 'private' or 'public'
default['rs-application_php']['bind_ip_type'] = 'private'

# The source control provider
default['rs-application_php']['scm']['provider'] = 'git'

# The repository to checkout the code from
default['rs-application_php']['scm']['repository'] = nil

# The revision of application code to checkout from the repository
default['rs-application_php']['scm']['revision'] = nil

# The private key to access the repository via SSH
default['rs-application_php']['scm']['deploy_key'] = nil

# The name of the application
default['rs-application_php']['application_name'] = nil

# The root of the application
default['rs-application_php']['app_root'] = '/'

# The command used to perform application migration
#
# @example: To import database contents from the dump file for a LAMP server, the following can be set as the
# migration command:
#
#   node.override['rs-application_php']['migration_command'] =
#     "gunzip < #{dump_file}.sql.gz | mysql -u#{database_username} -p#{database_password} #{schema_name}"
#
default['rs-application_php']['migration_command'] = nil

# Whether to create the local settings file on the application deployment
default['rs-application_php']['write_settings_file'] = true

# The name of the local settings file to be generated by a template
default['rs-application_php']['local_settings_file'] = 'config/db.php'

# The name of the template that will be rendered to create the local settings file
default['rs-application_php']['settings_template'] = nil

# Database configuration

# The database provider
default['rs-application_php']['database']['provider'] = 'mysql'

# The database host
default['rs-application_php']['database']['host'] = 'localhost'

# The database username
default['rs-application_php']['database']['user'] = nil

# The database password
default['rs-application_php']['database']['password'] = nil

# The database schema name
default['rs-application_php']['database']['schema'] = nil

# Remote recipe to attach application server to load balancer
default['rs-application_php']['remote_attach_recipe'] = 'rs-haproxy::frontend'

# Remote recipe to detach application server from load balancer
default['rs-application_php']['remote_detach_recipe'] = 'rs-haproxy::frontend'

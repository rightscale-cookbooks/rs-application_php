#
# Cookbook Name:: rs-application_php
# Attribute:: default
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

# PHP packages to install
default['rs-application_php']['packages'] = []

# Application listen port
default['rs-application_php']['listen_port'] = 8080

# The source control provider
default['rs-application_php']['scm']['provider'] = 'git'

# The repository to checkout the code from
default['rs-application_php']['scm']['repository'] = nil

# The revision of application code to checkout from the repository
default['rs-application_php']['scm']['revision'] = nil

# The name of the application
default['rs-application_php']['application_name'] = nil

# The command used to perform application migration
default['rs-application_php']['migration_command'] = nil

# Whether to write settings file TODO: I'm not clear
default['rs-application_php']['write_settings_file'] = true

# The local settings file TODO: I'm not clear
default['rs-application_php']['local_settings_file'] = 'config/db.php'

# The settings template used to create the settings file TODO: I'm not clear
default['rs-application_php']['settings_template'] = 'db.php.erb'

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

# Application callback attributes

default['rs-application_php']['before_deploy'] = nil

default['rs-application_php']['before_migrate'] = nil

default['rs-application_php']['before_symlink'] = nil

default['rs-application_php']['before_restart'] = nil

default['rs-application_php']['after_restart'] = nil


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

default['rs-application_php']['packages'] = []

default['rs-application_php']['listen_port'] = 8080

default['rs-application_php']['scm']['provider'] = 'git'

default['rs-application_php']['scm']['repository'] = nil

default['rs-application_php']['scm']['revision'] = 'master'

default['rs-application_php']['packages'] = []

default['rs-application_php']['application_name'] = nil

default['rs-application_php']['migration_command'] = nil



default['rs-application_php']['write_settings_file'] = true

default['rs-application_php']['local_settings_file'] = 'config/db.php'

default['rs-application_php']['settings_template'] = 'db.php.erb'

# Database configuration

default['rs-application_php']['database']['provider'] = 'mysql'

default['rs-application_php']['database']['host'] = 'localhost'

default['rs-application_php']['database']['user'] = nil

default['rs-application_php']['database']['password'] = nil

default['rs-application_php']['database']['schema'] = nil

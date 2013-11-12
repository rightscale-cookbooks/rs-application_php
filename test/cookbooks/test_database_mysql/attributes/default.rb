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

default['test_database_mysql']['server_root_password'] = 'iamhardtoguess'
default['test_database_mysql']['database_name'] = 'app_test'
default['test_database_mysql']['app_user'] = 'app_user'
default['test_database_mysql']['app_password'] = 'apppass'

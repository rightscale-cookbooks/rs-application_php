#
# Cookbook Name:: rs-application_php
# Recipe:: tags
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

marker "recipe_start_rightscale" do
  template "rightscale_audit_entry.erb"
end

include_recipe 'rightscale_tag::default'

# Set up application server tags
app_name = RsApplicationPhp::Helper.get_friendly_app_name(node['rs-application_php']['application_name'])
rightscale_tag_application app_name do
  bind_ip_address RsApplicationPhp::Helper.get_bind_ip_address(node)
  bind_port node['rs-application_php']['listen_port'].to_i
  vhost_path node['rs-application_php']['app_root']
  action :create
end

#
# Cookbook Name:: rs-application_php
# Recipe:: application_backend
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

marker 'recipe_start_rightscale' do
  template 'rightscale_audit_entry.erb'
end

class Chef::Recipe
  include Rightscale::RightscaleTag
end

# Validate application name
RsApplicationPhp::Helper.validate_application_name(node['rs-application_php']['application_name'])

# Check if there is at least one load balancer in the deployment serving the application name
if find_load_balancer_servers(node, node['rs-application_php']['application_name']).empty?
  raise "No load balancer servers found in the deployment serving #{node['rs-application_php']['application_name']}!"
end

# Put this backend into consideration during tag queries
log 'Tagging the application server to put it into consideration during tag queries...'
machine_tag "application:active_#{node['rs-application_php']['application_name']}=true" do
  action :create
end


# Send remote recipe request
log "Running recipe '#{node['rs-application_php']['remote_attach_recipe']}' on all load balancers" +
 " with tags 'load_balancer:active_#{node['rs-application_php']['application_name']}=true'..."

remote_recipe "HAProxy Frontend - chef" do
  tags "load_balancer:active_#{node['rs-application_php']['application_name']}=true"
  attributes( {'APPLICATION_BIND_IP' => "text:#{node['cloud']["private_ips"][0]}",
      'APPLICATION_BIND_PORT' => "text:#{node['rs-application_php']['listen_port']}",
      'APPLICATION_SERVER_ID' => "text:#{node['rightscale']['instance_uuid']}",
      'POOL_NAME' => "text:#{node['rs-application_php']['application_name']}",
      'VHOST_PATH' => "text:#{node['rs-application_php']['vhost_path']}",
      'APPLICATION_ACTION' => "text:attach"})
  action :run
end

#execute 'Attach to load balancer(s)' do
#  command [
#    'rs_run_recipe',
#    '--name', node['rs-application_php']['remote_attach_recipe'],
#    '--recipient_tags', "load_balancer:active_#{node['rs-application_php']['application_name']}=true",
#    '--json', remote_request_json
#  ]
#end
#
#file remote_request_json do
#  action :delete
#end

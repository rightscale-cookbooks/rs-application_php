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

marker "recipe_start_rightscale" do
  template "rightscale_audit_entry.erb"
end

class Chef::Recipe
  include Rightscale::RightscaleTag
end

include_recipe 'rightscale_tag::default'

# Put this backend in service
log "Putting the application server in service..."
machine_tag "application:active_#{node['rs-application_php']['application_name']}=true" do
  action :create
end

remote_request_hash = {
  'remote_recipe' => {
    'application_bind_ip' => get_bind_ip_address(node),
    'application_bind_port' => node['rs-application_php']['listen_port'],
    'application_server_id' => node['rightscale']['instance_uuid'],
    'pool_name' => node['rs-application_php']['application_name'],
    'application_action' => 'attach'
  }
}

file "/tmp/rs-haproxy_remote_request.json" do
  mode 0660
  content ::JSON.pretty_generate(remote_request_hash)
end

# Send remote recipe request
log "Running recipe '#{node['rs-application_php']['remote_attach_recipe']}' on all load balancers" +
 " with tags 'load_balancer:active_#{node['rs-application_php']['application_name']}=true'..."

execute "Attach me to load balancer" do
  command "rs_run_recipe --name '#{node['rs-application_php']['remote_attach_recipe']}'" +
    " --recipient_tags 'load_balancer:active_#{node['rs-application_php']['application_name']}=true'" +
    " --json '/tmp/rs-haproxy_remote_request.json'"
  only_if { ::File.exists?('/tmp/rs-haproxy_remote_request.json') }
end

file "/tmp/rs-haproxy_remote_request.json" do
  action :delete
end

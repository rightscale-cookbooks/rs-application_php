#
# Cookbook Name:: rs-application_php
# Recipe:: detach_server
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

# Detach application server from the load balancer serving the application name
unless node['cloud']['provider'] == 'vagrant'
  namespace = node['rs-application_php']['remote_detach_recipe'].split('::').first
  lb_tags = [
    "load_balancer:active_#{node['rs-application_php']['application_name']}=true"
  ]

  log "Detaching server from load balancer servers with tags '#{lb_tags.join(', ')}'" +
    "by calling #{node['rs-application_php']['remote_detach_recipe']} recipe..."
  remote_recipe "Detach me from load balancer" do
    recipe node['rs-application_php']['remote_detach_recipe']
    attributes namespace => {
      'application_server_id' => node['rightscale']['instance_uuid'],
      'application_name' => node['rs-application_php']['application_name'],
      'action' => 'detach'
    }
    recipients_tags lb_tags
  end
end

#
# Cookbook Name:: rs-application_php
# Recipe:: attach_server
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

# Attach application server to the load balancer serving the application name
unless node['cloud']['provider'] == 'vagrant'
  namespace = node['rs-application_php']['remote_attach_recipe'].split('::').first
  lb_tags = [
    "load_balancer:active_#{node['rs-application_php']['application_name']}=true"
  ]

  log "Attaching server to load balancer servers with tags '#{lb_tags.join(', ')}'" +
    " by calling #{node['rs-application_php']['remote_attach_recipe']} recipe..."
  remote_recipe "Attach me to load balancer" do
    recipe node['rs-application_php']['remote_attach_recipe']
    attributes namespace => {
      'application_bind_ip' => node['cloud']['private_ips'].first,
      'application_bind_port' => node['rs-application_php']['listen_port'],
      'application_server_id' => node['rightscale']['instance_uuid'],
      'application_name' => node['rs-application_php']['application_name'],
      'action' => 'attach'
    }
    recipients_tags lb_tags
  end
end

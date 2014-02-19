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
  node.override['rs-application_php']['remote_detach_recipe'] = 'rs-haproxy::default'

  log "Detaching application server from load balancer by calling #{node['rs-application_php']['remote_detach_recipe']} recipe..."
  remote_recipe "Detach me from load balancer" do
    recipe node['rs-application_php']['remote_detach_recipe']
    attributes 'remote_recipe' => {
      'server_id' => node['rightscale']['instance_uuid'],
      'pool_name' => node['rs-application_php']['application_name'],
      'action' => 'detach'
    }
    recipients_tags "loadbalancer:active_#{node['rs-application_php']['application_name']}=true"
  end
end

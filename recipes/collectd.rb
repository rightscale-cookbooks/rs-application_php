#
# Cookbook Name:: rs-application_php
# Recipe:: collectd
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

if node['rightscale'] && node['rightscale']['instance_uuid']
  node.override['collectd']['fqdn'] = node['rightscale']['instance_uuid']
end

log 'Setting up monitoring for apache...'

# On CentOS the Apache collectd plugin is installed separately
#package 'collectd-apache' do
#  only_if { node['platform'] =~ /redhat|centos/ }
#end

include_recipe 'rs-base::monitoring_collectd'

# Set up apache monitoring
collectd_plugin 'apache' do
  options(
    'URL' => "http://localhost:#{node['rs-application_php']['listen_port']}/server-status?auto"
  )
end

# Set up apache process monitoring
cookbook_file "#{node['collectd']['plugin_dir']}/apache_ps" do
  mode 0755
  source 'apache_ps'
end

#collectd_plugin 'apache_ps' do
#  template 'apache_ps.conf.erb'
#  cookbook 'rs-application_php'
#  options(collectd_lib: node['collectd']['plugin_dir'],
#          instance_uuid: node['rightscale']['instance_uuid'],
#          apache_user: node['apache']['user'])
#end

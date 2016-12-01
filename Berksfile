site :opscode

metadata

cookbook 'collectd', github: 'rightscale-cookbooks-contrib/chef-collectd', branch: 'generalize_install_for_both_centos_and_ubuntu'
cookbook 'application_php', github: 'rightscale-cookbooks-contrib/application_php', branch: 'template_fix_and_application_cookbook_upgrade'
cookbook 'mysql', github: 'rightscale-cookbooks-contrib/mysql', branch: 'rs-fixes'
cookbook 'dns', github: 'rightscale-cookbooks-contrib/dns', branch: 'rightscale_development_v2'
cookbook 'iptables', '~> 1.1.0' # keep for compatiblity with chef 11, can remove with chef 12
cookbook 'logrotate','1.9.2' # keep for compatiblity with chef 11, can remove with chef 12
cookbook 'aws','3.4.1' # keep for compatiblity with chef 11, can remove with chef 12
cookbook 'ohai', '3.0.0' # keep for compatiblity with chef 11, can remove with chef 12
cookbook 'runit', '~> 1.6.0' # keep for compatiblity with chef 11, can remove with chef 12
cookbook 'rightscale_tag',github: 'rightscale-cookbooks/rightscale_tag'
cookbook 'machine_tag', github: 'rightscale-cookbooks/machine_tag'
cookbook 'rsc_remote_recipe', github:'rightscale-services-cookbooks/rsc_remote_recipe'

group :integration do
  cookbook 'apt', '~> 2.9.2'
  cookbook 'yum','3.9.0'
  cookbook 'yum-epel', '~> 0.4.0'
  cookbook 'curl', '~> 1.1.0'
  cookbook 'fake', path: './test/cookbooks/fake'
  cookbook 'rhsm', '~> 1.0.0'
end

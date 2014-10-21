site :opscode

metadata

cookbook 'collectd', github: 'rightscale-cookbooks-contrib/chef-collectd', branch: 'generalize_install_for_both_centos_and_ubuntu'
cookbook 'application_php', github: 'rightscale-cookbooks-contrib/application_php', branch: 'template_fix_and_application_cookbook_upgrade'
cookbook 'mysql', github: 'rightscale-cookbooks-contrib/mysql', branch: 'rs-fixes'
cookbook 'rs-mysql', github: 'rightscale-cookbooks/rs-mysql'
cookbook 'dns', github: 'rightscale-cookbooks-contrib/dns', branch: 'rightscale_development_v2'

group :integration do
  cookbook 'apt', '~> 2.6.0'
  cookbook 'yum-epel', '~> 0.4.0'
  cookbook 'curl', '~> 1.1.0'
  cookbook 'fake', path: './test/cookbooks/fake'
  cookbook 'rhsm', '~> 1.0.0'
end

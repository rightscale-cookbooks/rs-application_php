site :opscode

metadata

cookbook 'collectd', github: 'EfrainOlivares/chef-collectd', ref: 'ec50609ed6eb193e0411f30aced91befa571940f'
cookbook 'application_php', github: 'arangamani-cookbooks/application_php', branch: 'template_fix_and_application_cookbook_upgrade'
cookbook 'rightscale_tag', github: 'rightscale-cookbooks/rightscale_tag'
cookbook 'rs-mysql', github: 'rightscale-cookbooks/rs-mysql'
cookbook 'dns', github: 'lopakadelp/dns', branch: 'rightscale_development_v2'

group :integration do
  cookbook 'apt', '~> 2.3.0'
  cookbook 'yum-epel', '~> 0.4.0'
  cookbook 'curl', '~> 1.1.0'
  cookbook 'fake', path: './test/cookbooks/fake'
  cookbook 'rhsm', github: 'rightscale-cookbooks/rhsm', branch: 'st_14_13_acu173881_compile_time_execute_and_enable_repos'
end

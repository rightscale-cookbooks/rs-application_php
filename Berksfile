site :opscode

metadata

cookbook 'collectd', github: 'EfrainOlivares/chef-collectd', ref: 'ec50609ed6eb193e0411f30aced91befa571940f'
cookbook 'application_php', github: 'lopakadelp/application_php', branch: 'updates_for_apache_24'
cookbook 'rightscale_tag', github: 'rightscale-cookbooks/rightscale_tag'
cookbook 'mysql', github: 'david-vo/mysql', branch: 'st_14_13_acu173881_add_rhel7_support'
cookbook 'rs-mysql', github: 'rightscale-cookbooks/rs-mysql'
cookbook 'dns', github: 'lopakadelp/dns', branch: 'rightscale_development_v2'

group :integration do
  cookbook 'apt', '~> 2.3.0'
  cookbook 'yum-epel', '~> 0.4.0'
  cookbook 'curl', '~> 1.1.0'
  cookbook 'fake', path: './test/cookbooks/fake'
  cookbook 'rhsm', github: 'rightscale-cookbooks/rhsm'
end

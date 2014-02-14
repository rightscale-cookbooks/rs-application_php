site :opscode

metadata

cookbook 'collectd', github: 'EfrainOlivares/chef-collectd', ref: 'ec50609ed6eb193e0411f30aced91befa571940f'
cookbook 'application_php', github: 'arangamani-cookbooks/application_php', branch: 'template_fix_and_application_cookbook_upgrade'
cookbook 'rightscale_tag', github: 'rightscale-cookbooks/rightscale_tag', branch: 'white_14_02_acu128798_three_tier_tags'

group :integration do
  cookbook 'apt', '~> 2.3.0'
  cookbook 'yum', '~> 2.4.2'
  cookbook 'curl'
  cookbook 'fake', path: './test/cookbooks/fake'
end

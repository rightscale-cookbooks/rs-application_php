site :opscode

metadata

cookbook 'rightscale_tag',github: 'rightscale-cookbooks/rightscale_tag', branch: 'chef-12-migration'
cookbook 'machine_tag', github: 'rightscale-cookbooks/machine_tag', branch: 'chef-12-migration'
cookbook 'rsc_remote_recipe', github:'rightscale-services-cookbooks/rsc_remote_recipe', branch: 'chef-12-migration'

group :integration do
  cookbook 'fake', path: './test/cookbooks/fake'
end

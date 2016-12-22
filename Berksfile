source 'https://supermarket.chef.io'

metadata

cookbook 'application_php', github: 'rightscale-cookbooks-contrib/application_php', branch: 'chef-12-migration'
cookbook 'rs-base', github: 'rightscale-cookbooks/rs-base', branch: 'chef-12-migration'
cookbook 'marker', github: 'rightscale-cookbooks/marker', branch: 'chef-12-migration'
cookbook 'rightscale_tag', github: 'rightscale-cookbooks/rightscale_tag', branch: 'chef-12-migration'
cookbook 'machine_tag', github: 'rightscale-cookbooks/machine_tag', branch: 'chef-12-migration'
cookbook 'rsc_remote_recipe', github: 'rightscale-services-cookbooks/rsc_remote_recipe', branch: 'chef-12-migration'
cookbook 'ephemeral_lvm', github: 'rightscale-cookbooks/ephemeral_lvm', branch: 'chef-12-migration'

group :integration do
  cookbook 'fake', path: './test/cookbooks/fake'
end

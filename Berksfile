source 'https://supermarket.chef.io'

metadata

cookbook 'application_php', github: 'rightscale-cookbooks-contrib/application_php', branch: 'chef-12-migration'
cookbook 'rs-base', github: 'rightscale-cookbooks/rs-base'
cookbook 'marker', github: 'rightscale-cookbooks/marker'
cookbook 'rightscale_tag', github: 'rightscale-cookbooks/rightscale_tag'
cookbook 'machine_tag', github: 'rightscale-cookbooks/machine_tag'
cookbook 'rsc_remote_recipe', github: 'rightscale-services-cookbooks/rsc_remote_recipe'
cookbook 'ephemeral_lvm', github: 'rightscale-cookbooks/ephemeral_lvm'

group :integration do
  cookbook 'fake', path: './test/cookbooks/fake'
end

# frozen_string_literal: true
source 'https://supermarket.chef.io'

metadata

cookbook 'application_php', git: 'git://github.com/rightscale-cookbooks-contrib/application_php', branch: 'chef-12-migration'
cookbook 'rs-base', git: 'git://github.com/rightscale-cookbooks/rs-base'
cookbook 'marker', git: 'git://github.com/rightscale-cookbooks/marker'
cookbook 'rightscale_tag', git: 'git://github.com/rightscale-cookbooks/rightscale_tag'
cookbook 'machine_tag', git: 'git://github.com/rightscale-cookbooks/machine_tag'
cookbook 'rsc_remote_recipe', git: 'git://github.com/rightscale-services-cookbooks/rsc_remote_recipe'
cookbook 'ephemeral_lvm', git: 'git://github.com/rightscale-cookbooks/ephemeral_lvm'

group :integration do
  cookbook 'fake', path: './test/cookbooks/fake'
end

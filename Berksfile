# frozen_string_literal: true
source 'https://supermarket.chef.io'

metadata

cookbook 'application_php', github: 'rightscale-cookbooks-contrib/application_php', branch: 'chef-12-migration'
cookbook 'rs-base', github: 'rightscale-cookbooks/rs-base'
cookbook 'rsc_remote_recipe', github: 'rightscale-services-cookbooks/rsc_remote_recipe'

group :integration do
  cookbook 'fake', path: './test/cookbooks/fake'
end

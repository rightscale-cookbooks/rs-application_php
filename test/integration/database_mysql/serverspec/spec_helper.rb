# frozen_string_literal: true
require 'serverspec'
require 'pathname'

set :backend, :exec

RSpec.configure do |conf|
  conf.path = '/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin'
end

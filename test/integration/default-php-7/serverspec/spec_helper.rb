# frozen_string_literal: true
require 'serverspec'
require 'pathname'
require 'json'

RSpec.configure do |conf|
  conf.path = '/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin'
end

require 'serverspec'
require 'pathname'

RSpec.configure do |conf|
  conf.path = '/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin'
end

require 'serverspec'
require 'pathname'
require 'json'

include Serverspec::Helper::Exec
include Serverspec::Helper::DetectOS

RSpec.configure do |conf|
  conf.path = '/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin'
end

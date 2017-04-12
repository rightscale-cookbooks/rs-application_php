<<<<<<< HEAD
# frozen_string_literal: true
require 'serverspec'
require 'pathname'
require 'json'

RSpec.configure do |conf|
  conf.path = '/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin'
end
=======
# frozen_string_literal: true
require 'serverspec'
require 'pathname'
require 'json'

set :backend, :exec

RSpec.configure do |conf|
  conf.path = '/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin'
end
>>>>>>> d828cf82a88f9abcf57fbad0b3b80a16e014f6d1

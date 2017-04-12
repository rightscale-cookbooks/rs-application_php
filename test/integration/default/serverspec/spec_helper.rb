# frozen_string_literal: true
require 'serverspec'
require 'pathname'
require 'json'

set :backend, :exec

RSpec.configure do |conf|
  conf.path = '/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin'
end

module Helper
  begin
    require 'ohai'
  rescue LoadError
    require 'rubygems/dependency_installer'
    Gem::DependencyInstaller.new.install('ohai')
    require 'ohai'
  end

  def ip_address?
    ohai = Ohai::System.new
    ohai.all_plugins
    @node = ohai
    @node['ipaddress']
  end
end

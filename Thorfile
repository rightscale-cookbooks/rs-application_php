# encoding: utf-8

require 'bundler'
require 'bundler/setup'
require 'thor/foodcritic'
require 'thor/scmversion'
require 'berkshelf/thor'

begin
  require 'kitchen/thor_tasks'
  Kitchen::ThorTasks.new
rescue LoadError
  puts ">>>>> Kitchen gem not loaded, omitting tasks" unless ENV['CI']
end

class Default < Thor
  include Thor::RakeCompat

  desc "upload", "Package berkshelf into archive and upload to S3"
  option :force
  def upload
    version = "0.0.1"
    File.open("VERSION", "r") { |f| version = f.read() }
    force = "--force" if options[:force]
    exec "berks_to_rightscale release rs-st-php #{version} --container=devs-us-west --provider=aws #{force}"
  end
end

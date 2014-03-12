#
# Cookbook Name:: rs-application_php
# Library:: helper
#
# Copyright (C) 2013 RightScale, Inc.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#    http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

module RsApplicationPhp
  # This module contains helper methods for rs-application_php cookbook.
  #
  module Helper
    # This is a simple helper method that will accept a list of package names as an array and convert them to a
    # Hash (key as the package name and value as the package version) if the package names contain the version number
    # in the format: package=version
    #
    # @param packages [Array<String>] list of packages
    #
    # @return [Hash{String => String}, Array<String>] a Hash of package name and version or array of package names
    #
    # @example Split package by name and version
    #   >> RsApplicationPhp::Helper.split_by_package_name_and_version(['pkg1', 'pkg2=2.0'])
    #   => {'pkg1' => nil, 'pkg2' => '2.0'}
    #
    def self.split_by_package_name_and_version(packages)
      # The `packages` attribute in application resource supports both Hash and Array formats.
      # If any of the package given has version specified (in the format package=version),
      # use the hash format with the package name as the key and package version as the value
      # otherwise use the array format with just the package names.
      #
      if packages.any? { |pkg| pkg =~ /(.*)=(.*)/ }
        packages_hash = {}
        packages.each do |pkg|
          if pkg =~ /(.*)=(.*)/
            packages_hash[$1] = $2
          else
            packages_hash[pkg] = nil
          end
        end
        packages_hash
      else
        packages
      end
    end

    # Gets the IP address that the application server will bind to.
    #
    # @param node [Chef::Node] the chef node
    #
    # @return [String] the bind IP address
    #
    def self.get_bind_ip_address(node)
      case node['rs-application_php']['bind_ip_type']
      when /private/i
        node['cloud']['private_ips'].first
      when /public/i
        node['cloud']['public_ips'].first
      end
    end
  end
end

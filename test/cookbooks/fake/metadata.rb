# frozen_string_literal: true
name             'fake'
maintainer       'RightScale, Inc.'
maintainer_email 'cookbooks@rightscale.com'
license          'Apache 2.0'
description      'Installs/Configures a test mysql database server'
version          '0.1.0'

depends 'database'
depends 'mysql', '~> 8.2'
depends 'mysql2_chef_gem'
depends 'yum-mysql-community'

recipe 'fake::database_mysql', 'Prepares the test mysql database'
recipe 'fake::create_secrets', 'creates rightlink secrets'

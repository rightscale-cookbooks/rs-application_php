name             'fake'
maintainer       'RightScale, Inc.'
maintainer_email 'cookbooks@rightscale.com'
license          'Apache 2.0'
description      'Installs/Configures a test mysql database server'
version          '0.1.0'

depends 'database'
depends 'mysql'
depends 'mysql2_chef_gem'

recipe 'fake::database_mysql', 'Prepares the test mysql database'
recipe 'fake::create_secrets', 'creates rightlink secrets'

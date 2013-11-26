name             'test_database_mysql'
maintainer       'RightScale, Inc.'
maintainer_email 'cookbooks@rightscale.com'
license          'Apache 2.0'
description      'Installs/Configures a test mysql database server'
version          '0.1.0'

depends 'database'

recipe 'test_database_mysql::prepare', 'Prepares the test mysql database'

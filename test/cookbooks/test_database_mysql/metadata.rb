name             'test-db'
maintainer       'YOUR_NAME'
maintainer_email 'YOUR_EMAIL'
license          'All rights reserved'
description      'Installs/Configures test-db'
version          '0.1.0'

depends 'database'

recipe 'test_database_mysql::prepare', 'Prepares the test mysql database'

name             "rs-application_php"
maintainer       "RightScale"
maintainer_email "support@rightscale.com"
license          "All rights reserved"
description      "Installs/Configures a PHP application server"
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          "0.1.0"

depends 'apt'
depends 'application'
depends 'application_php'
depends 'git'

#depends 'rs-app'
#depends 'rs-scm-ast'
#depends 'rs-scm-git'
#depends 'rs-scm-subversion'

recipe "rs-application_php::default", "Installs/configures PHP application server"

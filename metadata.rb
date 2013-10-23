name             "rs-st-php"
maintainer       "RightScale"
maintainer_email "support@rightscale.com"
license          "All rights reserved"
description      "Installs/Configures rs-st-php"
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          "0.1.0"

depends 'application'
depends 'application_php'
depends 'git'
depends 'subversion'

depends 'rs-app'
depends 'rs-scm-ast'
depends 'rs-scm-git'
depends 'rs-scm-subversion'

recipe "rs-st-php::default", "Installs PHP application server"

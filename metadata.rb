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
depends 'database'

#depends 'rs-app'
#depends 'rs-scm-ast'
#depends 'rs-scm-git'
#depends 'rs-scm-subversion'

recipe 'rs-application_php::default', 'Installs/configures PHP application server'

attribute 'rs-application_php/listen_port',
  :display_name => 'Application Listen Port',
  :description => 'The port to use for the application to bound',
  :default => '8080',
  :recipes => ['rs-application_php::default']

attribute 'rs-application_php/scm/provider',
  :display_name => 'SCM Provider',
  :description => 'The provider used for source control management',
  :default => 'git',
  :choice => ['git'],
  :recipes => ['rs-application_php::default']

attribute 'rs-application_php/scm/repository',
  :display_name => 'Application Repository URL',
  :description => 'The repository location to download application code',
  :recipes => ['rs-application_php::default']

attribute 'rs-application_php/scm/revision',
  :display_name => 'Application Repository Revision',
  :description => 'The revision of application code to download from the repository',
  :recipes => ['rs-application_php::default']

attribute 'rs-application_php/application_name',
  :display_name => 'Application Name',
  :description => 'The name of the application',
  :recipes => ['rs-application_php::default']

attribute 'rs-application_php/migration_command',
  :display_name => 'Migration Command',
  :description => 'The command used to perform application migration',
  :recipes => ['rs-application_php::default']

attribute 'rs-application_php/write_settings_file',
  :display_name => 'Write Settings File',
  :description => 'Whether to write the settings file in the application code',
  :recipes => ['rs-application_php::default']

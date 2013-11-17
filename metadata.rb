name             "rs-application_php"
maintainer       "RightScale"
maintainer_email "support@rightscale.com"
license          "All rights reserved"
description      "Installs/Configures a PHP application server"
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          "0.1.0"

depends 'apt', '~> 2.3.0'
depends 'application', '~> 4.1.4'
depends 'application_php', '~> 2.0.0'
depends 'database', '~> 1.5.2'
depends 'git', '~> 2.7.0'
depends 'php', '~> 1.2.6'

recipe 'rs-application_php::default', 'Installs/configures PHP application server'

attribute 'rs-application_php/listen_port',
  :display_name => 'Application Listen Port',
  :description => 'The port to use for the application to bound',
  :default => '8080',
  :required => 'optional',
  :recipes => ['rs-application_php::default']

attribute 'rs-application_php/scm/provider',
  :display_name => 'SCM Provider',
  :description => 'The provider used for source control management. Only git is supported.',
  :default => 'git',
  :choice => ['git'],
  :required => 'optional',
  :recipes => ['rs-application_php::default']

attribute 'rs-application_php/scm/repository',
  :display_name => 'Application Repository URL',
  :description => 'The repository location to download application code',
  :required => 'required',
  :recipes => ['rs-application_php::default']

attribute 'rs-application_php/scm/revision',
  :display_name => 'Application Repository Revision',
  :description => 'The revision of application code to download from the repository',
  :required => 'required',
  :recipes => ['rs-application_php::default']

attribute 'rs-application_php/application_name',
  :display_name => 'Application Name',
  :description => 'The name of the application',
  :required => 'required',
  :recipes => ['rs-application_php::default']

attribute 'rs-application_php/migration_command',
  :display_name => 'Migration Command',
  :description => 'The command used to perform application migration',
  :requried => 'optional',
  :recipes => ['rs-application_php::default']

attribute 'rs-application_php/write_settings_file',
  :display_name => 'Write Settings File',
  :description => 'Whether to write the settings file in the application code',
  :default => 'true',
  :required => 'recommended',
  :recipes => ['rs-application_php::default']

attribute 'rs-application_php/local_settings_file',
  :display_name => 'Local Settings File',
  :description => 'not clear yet', # TODO: Fix it
  :default => 'config/db.php',
  :required => 'recommended',
  :recipes => ['rs-application_php::default']

attribute 'rs-application_php/database/provider',
  :display_name => 'Database Provider',
  :description => 'The database provider the application should connect to. Only MySQL is currently supported.',
  :default => 'mysql',
  :choice => ['mysql'],
  :required => 'optional',
  :recipes => ['rs-application_php::default']

attribute 'rs-application_php/database/host',
  :display_name => 'Database Host',
  :description => 'The FQDN of the database server',
  :default => 'localhost',
  :required => 'recommended',
  :recipes => ['rs-application_php::default']

attribute 'rs-application_php/database/user',
  :display_name => 'Database User',
  :description => 'The username used to connect to the database',
  :required => 'recommended',
  :recipes => ['rs-application_php::default']

attribute 'rs-application_php/database/password',
  :display_name => 'Database Password',
  :description => 'The password used to connect to the database',
  :required => 'recommended',
  :recipes => ['rs-application_php::default']

attribute 'rs-application_php/database/schema',
  :display_name => 'Database Schema',
  :description => 'The schema name used to connect to the database',
  :required => 'recommended',
  :recipes => ['rs-application_php::default']

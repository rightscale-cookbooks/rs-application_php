name             "rs-application_php"
maintainer       "RightScale"
maintainer_email "support@rightscale.com"
license          "All rights reserved"
description      "Installs/Configures a PHP application server"
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          "1.0.0"

depends 'marker', '~> 1.0.0'
depends 'application', '~> 4.1.4'
depends 'application_php', '~> 2.0.0'
depends 'database', '~> 1.5.2'
depends 'git', '~> 2.7.0'
depends 'php', '~> 1.2.6'
depends 'collectd', '~> 1.1.0'
depends 'rightscale_tag'

recipe 'rs-application_php::default', 'Installs/configures PHP application server'
recipe 'rs-application_php::tags', 'Sets up application server tags used in a 3-tier deployment setup'
recipe 'rs-application_php::monitoring', 'Sets up monitoring for the application server'

attribute 'rs-application_php/packages',
  :display_name => 'Packages to install',
  :description => 'List of packages to be installed before starting the deployment.' +
    ' Package versions can be specified. Example: pkg1, pkg2=2.0',
  :type => 'array',
  :required => 'optional',
  :recipes => ['rs-application_php::default']

attribute 'rs-application_php/listen_port',
  :display_name => 'Application Listen Port',
  :description => 'The port to use for the application to bind. Example: 8080',
  :default => '8080',
  :required => 'optional',
  :recipes => ['rs-application_php::default']

attribute 'rs-application_php/scm/repository',
  :display_name => 'Application Repository URL',
  :description => 'The repository location to download application code. Example: git://github.com/rightscale/examples.git',
  :required => 'required',
  :recipes => ['rs-application_php::default']

attribute 'rs-application_php/scm/revision',
  :display_name => 'Application Repository Revision',
  :description => 'The revision of application code to download from the repository. Example: 37741af646ca4181972902432859c1c3857de742',
  :required => 'required',
  :recipes => ['rs-application_php::default']

attribute 'rs-application_php/scm/deploy_key',
  :display_name => 'Application Deploy Key',
  :description => 'The private key to access the repository via SSH. Example: Cred:APP_DEPLOY_KEY',
  :required => 'optional',
  :recipes => ['rs-application_php::default']

attribute 'rs-application_php/application_name',
  :display_name => 'Application Name',
  :description => 'The name of the application. Example: hello_world',
  :required => 'required',
  :recipes => ['rs-application_php::default']

attribute 'rs-application_php/app_root',
  :display_name => 'Application Root',
  :description => 'The path of application root relative to /usr/local/www/sites/<application name> directory. Example: my_app',
  :default => '/',
  :required => 'optional',
  :recipes => ['rs-application_php::default']

attribute 'rs-application_php/migration_command',
  :display_name => 'Migration Command',
  :description => 'The command used to perform application migration. Example: php app/console doctrine:migrations:migrate',
  :requried => 'optional',
  :recipes => ['rs-application_php::default']

attribute 'rs-application_php/database/host',
  :display_name => 'Database Host',
  :description => 'The FQDN of the database server. Example: db.example.com',
  :default => 'localhost',
  :required => 'recommended',
  :recipes => ['rs-application_php::default']

attribute 'rs-application_php/database/user',
  :display_name => 'Database User',
  :description => 'The username used to connect to the database. Example: dbuser',
  :required => 'recommended',
  :recipes => ['rs-application_php::default']

attribute 'rs-application_php/database/password',
  :display_name => 'Database Password',
  :description => 'The password used to connect to the database. Example: dbpass',
  :required => 'recommended',
  :recipes => ['rs-application_php::default']

attribute 'rs-application_php/database/schema',
  :display_name => 'Database Schema',
  :description => 'The schema name used to connect to the database. Example: app_test',
  :required => 'recommended',
  :recipes => ['rs-application_php::default']

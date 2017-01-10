name             'rs-application_php'
maintainer       'RightScale, Inc.'
maintainer_email 'cookbooks@rightscale.com'
license          'Apache 2.0'
description      'Installs/Configures a PHP application server'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '1.2.4'

depends 'marker', '~> 1.0.1'
depends 'application', '~> 4.1.4'
depends 'application_php', '~> 2.0.0'
depends 'database', '~> 1.5.2'
depends 'git', '~> 4.0.2'
depends 'php', '~> 1.5.0'
depends 'dmg', '~> 2.4.0'
depends 'collectd', '~> 1.1.0'
depends 'rightscale_tag', '~> 1.2.1'
depends 'rsc_remote_recipe', '~> 10.0.0'
depends 'mysql', '~> 4.0.20'

recipe 'rs-application_php::default', 'Installs/configures PHP application server'
recipe 'rs-application_php::tags', 'Sets up application server tags used in a 3-tier deployment setup'
recipe 'rs-application_php::collectd', 'Sets up collectd monitoring for the application server'
recipe 'rs-application_php::application_backend', 'Attaches the application server to a load balancer'
recipe 'rs-application_php::application_backend_detached', 'Detaches the application server' +
  ' from a load balancer'

attribute 'rs-application_php/packages',
  :display_name => 'Additional PHP Packages to Install',
  :description => 'List of additional PHP packages to be installed before starting the deployment.' +
    ' Package versions can be specified. Example: pkg1, pkg2=2.0',
  :type => 'array',
  :required => 'optional',
  :recipes => ['rs-application_php::default']

attribute 'rs-application_php/listen_port',
  :display_name => 'Application Listen Port',
  :description => 'The port to use for the application to bind. Example: 8080',
  :default => '8080',
  :required => 'optional',
  :recipes => [
    'rs-application_php::default',
    'rs-application_php::tags',
    'rs-application_php::application_backend',
  ]

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
  :description => 'The name of the application. This name is used to generate the path of the' +
    ' application code and to determine the backend pool in a load balancer server that the' +
    ' application server will be attached to. Application names can have only alphanumeric' +
    ' characters and underscores. Example: hello_world',
  :required => 'required',
  :recipes => [
    'rs-application_php::default',
    'rs-application_php::tags',
    'rs-application_php::application_backend',
    'rs-application_php::application_backend_detached',
  ]

attribute 'rs-application_php/vhost_path',
  :display_name => 'Virtual Host Name/Path',
  :description => 'The virtual host served by the application server. The virtual host name can be' +
    ' a valid domain/path name supported by the access control lists (ACLs) in a load balancer.' +
    ' Ensure that no two application servers in the same deployment having the same' +
    ' application name have different vhost paths. Example: www.example.com, /index',
  :required => 'required',
  :recipes => [
    'rs-application_php::tags',
    'rs-application_php::application_backend',
  ]

attribute 'rs-application_php/app_root',
  :display_name => 'Application Root',
  :description => 'The path of application root relative to /usr/local/www/sites/<application name> directory. Example: my_app',
  :default => '/',
  :required => 'optional',
  :recipes => [
    'rs-application_php::default',
    'rs-application_php::tags',
  ]

attribute 'rs-application_php/bind_network_interface',
  :display_name => 'Application Bind Network Interface',
  :description => "The network interface to use for the bind address of the application server." +
    " It can be either 'private' or 'public' interface.",
  :default => 'private',
  :choice => ['public', 'private'],
  :required => 'optional',
  :recipes => [
    'rs-application_php::default',
    'rs-application_php::tags',
  ]

attribute 'rs-application_php/migration_command',
  :display_name => 'Application Migration Command',
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
  :display_name => 'MySQL Application Username',
  :description => 'The username used to connect to the database. Example: cred:MYSQL_APPLICATION_USERNAME',
  :required => 'recommended',
  :recipes => ['rs-application_php::default']

attribute 'rs-application_php/database/password',
  :display_name => 'MySQL Application Password',
  :description => 'The password used to connect to the database. Example: cred:MYSQL_APPLICATION_PASSWORD',
  :required => 'recommended',
  :recipes => ['rs-application_php::default']

attribute 'rs-application_php/database/schema',
  :display_name => 'MySQL Database Name',
  :description => 'The schema name used to connect to the database. Example: mydb',
  :required => 'recommended',
  :recipes => ['rs-application_php::default']

attribute 'rs-application_php/write_settings_file',
  :display_name => 'Write PHP settings file',
  :description => 'Write PHP settings file to config/db.php',
  :required => 'optional',
  :recipes => ['rs-application_php::default']

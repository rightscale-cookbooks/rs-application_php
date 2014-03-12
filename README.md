# rs-application_php cookbook

[![Build Status](https://travis-ci.org/rightscale-cookbooks/rs-application_php.png?branch=master)](https://travis-ci.org/rightscale-cookbooks/rs-application_php)

Sets up a PHP application server by checking out code from a `git` repository and connecting to a `mysql` database.

Github Repository: https://github.com/rightscale-cookbooks/rs-application_php

# Requirements

* Chef 11 or higher
* Cookbook requirements
  * [marker](http://community.opscode.com/cookbooks/marker)
  * [application](http://community.opscode.com/cookbooks/application)
  * [application_php](http://community.opscode.com/cookbooks/application_php)
  * [database](http://community.opscode.com/cookbooks/database)
  * [php](http://community.opscode.com/cookbooks/php)
  * [git](http://community.opscode.com/cookbooks/git)
* Platform
  * Ubuntu 12.04
  * CentOS 6

# Usage

* Add the `rs-application_php::default` recipe to your run list to set up a PHP application server.
  When the database inputs are provided, this recipe sets up a MySQL client and establishes
  connection with a MySQL database server.
* Add the `rs-application_php::tags` recpie to the run list to set up application-related machine
  tags on the application server. Refer to [rightscale_tag cookbook][Application Tags] for the list
  of tags set on an application server.
* Add the `rs-application_php::collectd` recipe to install collectd packages for apache and set up
  monitoring for the application server.

[Application Tags]: https://github.com/rightscale-cookbooks/rightscale_tag#application-servers

This cookbook is based on the [application] and [application_php] cookbooks and more information is available from them.

[application]: https://github.com/poise/application/blob/master/README.md
[application_php]: https://github.com/poise/application_php/blob/master/README.md

# Attributes

* `node['rs-application_php']['packages']` - List of packages to be installed before
  starting the deployment. Package versions can be specified in this format `<package>=<version>`.
  Example: `pkg1, pkg2=2.0`.
* `node['rs-application_php']['listen_port']` - The port to use for the application to bind.
  Default: `8080`.
* `node['rs-application_php']['bind_ip_type']` - The type of the IP address for the application to
  bind. This attribute can be either 'public' or 'private'. Default: 'private'.
* `node['rs-application_php']['scm']['repository']` - The repository location to download
  application code. Example: `git://github.com/rightscale/examples.git`.
* `node['rs-application_php']['scm']['revision']` - The revision of application code to
  download from the repository. Example: `37741af646ca4181972902432859c1c3857de742`.
* `node['rs-application_php']['application_name']` - The name of the application. Example:
  `hello_world`.
* `node['rs-application_php]['app_root']` - The path of application root relative to
  `/usr/local/www/sites/<application name>` directory. Default: `/`.
* `node['rs-application_php']['migration_command']` - The command used to perform
  application migration. Example: `php app/console doctrine:migrations:migrate`.
* `node['rs-application_php']['write_settings_file']` - Create the local settings file on the
  application deployment. Default: `true`.
* `node['rs-application_php]['local_settings_file']` - The name of local settings file to be
  created. The name can also be path relative to the application code. Default: `config/db.php`.
  Example: `LocalSettings.php`, `config/db.php`.
* `node['rs-application_php']['settings_template']` - The name of template that will be
  rendered to create the local settings file. If this attribute is set to `nil`, then the name
  of the template that will be used to create the settings file is obtained from the
  `local_settings_file` attribute - `<local_settings_file>.erb`. For example, if the
  `local_settings_file` is `config/db.php`, the template used to generate the settings file will
  be `db.php.erb`. Default: `nil`
* `node['rs-application_php']['database']['host']` - The FQDN of the database server.
  Default: `localhost`.
* `node['rs-application_php']['database']['user']` - The username used to connect to the
  database. Example: `dbuser`.
* `node['rs-application_php']['database']['password']` - The password used to connect to the
  database. Example: `dbpass`.
* `node['rs-application_php']['database']['schema']` - The schema name used to connect to the
  database. Example: `app_test`.
* `node['rs-application_php']['remote_attach_recipe']` - The recipe to run on remote load balancer
  servers to attach the application server to the load balancer servers. Example: `rs-haproxy::frontend`.
* `node['rs-application_php']['remote_detach_recipe']` - The recipe to run on remote load balancer
  servers to detach the application server from the load balancer servers. Example: `rs-haproxy::frontend`.


# Recipes

## `rs-application_php::default`

Based on the attributes provided, this recipe will deploy the given application using the application LWRP.

## `rs-application_php::tags`

This recipe tags the application server with application server tags used in setting up a 3-tier architecture
in a RightScale environment. Refer to [Application Servers section in rightscale_tag cookbook][Application Server Tags]
for the list of tags set on the application server.

[Application Server Tags]:https://github.com/rightscale-cookbooks/rightscale_tag#application-servers

## `rs-application_php::collectd`

This recipe sets up collectd monitoring for the application server by installing the collectd package for Apache.

## `rs-application_php::application_backend`

This recipe attaches the application server to the load balancer servers serving the same
application name as that of the application server and existing in the same deployment. This recipe
schedules the execution of the recipe specified in `node['rs-application_php']['remote_attach_recipe']`
attribute on the load balancer servers matching the `load_balancers:active_<application_name>=true`
tag. This remote recipe execution is achieved by the [rs_run_recipe utility][rs_run_recipe Utility].

## `rs-application_php::application_backend_detached`

This recipe detaches the application server from the load balancer servers serving the same
application name as that of the application server and existing in the same deployment.  This recipe
schedules the execution of the recipe specified in `node['rs-application_php']['remote_detach_recipe']`
attribute on the load balancer servers matching the `load_balancers:active_<application_name>=true`
tag. This remote recipe execution is achieved by the [rs_run_recipe utility][rs_run_recipe Utility].

[rs_run_recipe Utility]: http://support.rightscale.com/12-Guides/RightLink/02-RightLink_5.9/Using_RightLink/Command_Line_Utilities#rs_run_recipe

# Author

Author:: RightScale, Inc. (<cookbooks@rightscale.com>)

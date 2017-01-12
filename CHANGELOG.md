rs-application_php Cookbook CHANGELOG
==========================

This file is used to list changes made in each version of the rs-application_php cookbook.

v2.0.0
------
- Chef 12 Migration

v1.2.5
------
- pins nio4r
- pins rightscale_tag
- pins machine_tag
- pins rsc_remote_recipe

v1.2.4
------
- fix cookbook and gem compatiblity

v1.2.3
------
- use rightscale_tag v1.2.1
- pin version of aws, ohai, logrotate to retain chef 11 support

v1.2.2
------
- Changing default['rs-application_php']['write_settings_file'] to false

v1.2.1
------
- Updating php cookbook to 1.5.0
- Pinning mysql cookbook to 4.0.20

v1.2.0
------
- Add support for RightLink 10
- Remove support for RightLink 6

v1.1.1
------
- Add kitchen testing for RHEL 6.5 and Ubuntu 14.04.
- Update versions of dependent cookbooks.
- Update testing code to abide by Serverspec v2.

v1.1.0
------

- Release to coincide with the v14.0.0 Beta ServerTemplates.

v1.0.0
------

- Initial release

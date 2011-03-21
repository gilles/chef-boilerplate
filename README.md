Overview
========

My base chef repo.

Contains the following cookbooks:

 * users
 * sudo
 * git
 * application for nginx / unicorn / rails

And their dependencies.

Changes from official cookooks
========

Application
--------

new recipe application::nginx_unicorn

application::unicorn uses god for unicorn supervision

Nginx
--------

compile with status module

Ruby
--------

Had weird errors with ubuntu ruby packages, removed bad packages.

Usage
========

Just clone, setup your .chef and chef-client as explained in: http://help.opscode.com/kb/start/2-setting-up-your-user-environment and http://help.opscode.com/kb/start/4-setting-up-a-chef-client

Update the data bags with the relevant infos. Rename the 'app' data bag with whatever makes sense.

include the 'production' or 'staging' role for a base installation


TODO
========

* mongodb
* rvm
* monitoring
* Cleanup dependecies for unused cookbooks?
Overview
========

Boilerplate to setup a new chef repo. It's really oriented nginx / unicorn / rails / mongodb but the base cookbooks/roles/data_bags are there.

The primary goal of the boilerplate is to create the base instance image. The secondary goal is to setup a nginx / unicorn / rails / mongodb application.

Contains the following cookbooks:

 * users
 * sudo
 * application for nginx / unicorn / rails
 * rvm
 * A base cookbook

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

The base cookbook
========

The base cookbook contains several base recipes:

* packages => a list of packages all machines should have
* ps1 => a system wide PS1 where all prod machines are red and staging machines are yellow

The PS1 recipe contains modified system wide bashrc / profile and skeleton bashrc to solve:

* They override PS1
* -z XXX && return does not play nice with RVM: [http://rvm.beginrescueend.com/rvm/install/](http://rvm.beginrescueend.com/rvm/install/) (troubleshoot)

Usage
========

Just clone, setup your .chef and chef-client as explained in:
[http://help.opscode.com/kb/start/2-setting-up-your-user-environment](http://help.opscode.com/kb/start/2-setting-up-your-user-environment)
and [http://help.opscode.com/kb/start/4-setting-up-a-chef-client](http://help.opscode.com/kb/start/4-setting-up-a-chef-client)
<br/><br/>
Include the 'production' or 'staging' role for a base installation
<br/><br/>
Update the data bags with the relevant infos. Rename and update the 'app' data bag with whatever makes sense for you.

TODO
========

* mongodb + make it work with the application cookbook.
* monitoring (but which one)
* Make the application cookbook play nice with RVM
* Cleanup dependecies for unused cookbooks? Not sure about that.
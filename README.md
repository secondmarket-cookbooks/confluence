Description
===========

Installs and configures Atlassian Confluence, an enterprise Wiki.

Requirements
============

Platform
--------

* CentOS, Red Hat, Fedora

Cookbooks
---------

* database
* java
* mysql
* postgresql

Note: Confluence, like most Atlassian products, requires the Oracle JDK.

Attributes
==========

Mostly no user-servicable parts in here, but you might want to change:

* `node['confluence']['crowd_sso']['sso_appname']`
* `node['confluence']['crowd_sso']['sso_password']`
* `node['confluence']['crowd_sso']['crowd_base_url']`

if you plan to use the crowd_sso recipe.

Usage
=====

default
-------

Does nothing. Use the server recipe.

server
------

Fetches Confluence tarball from Atlassian, installs it, sets the permissions correctly for a new user "crowd" so that it runs unprivileged.

crowd_sso
---------

Does a partial integration of Confluence with Atlassian Crowd single-sign-on. Some things (like editing Crowd's seraph-config.xml to turn on SSO) aren't supported yet.

License and Author
==================

Author:: Julian C. Dunn (<jdunn@secondmarket.com>)

Copyright:: 2012, SecondMarket Labs, LLC.

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.

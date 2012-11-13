#
# Cookbook Name:: confluence
# Attributes:: default 
#
# Copyright 2012, SecondMarket Labs, LLC
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

default['confluence']['version']='4.3.2'
default['confluence']['parentdir']='/opt'

default['confluence']['installdir']="#{node['confluence']['parentdir']}/atlassian-confluence-#{node['confluence']['version']}"
default['confluence']['tarball']="atlassian-confluence-#{node['confluence']['version']}.tar.gz"
default['confluence']['url']="http://www.atlassian.com/software/confluence/downloads/binary/#{node['confluence']['tarball']}"

default['confluence']['workdir']="/var/confluence-home"

default['confluence']['crowd_sso']['sso_appname']="confluence"
default['confluence']['crowd_sso']['sso_password']="confluence"
default['confluence']['crowd_sso']['crowd_base_url']="http://localhost:8095/crowd/"

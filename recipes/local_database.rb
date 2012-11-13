#
# Cookbook Name:: confluence
# Recipe:: local_database
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

::Chef::Recipe.send(:include, Opscode::OpenSSL::Password)

include_recipe "postgresql::server"
include_recipe "database::postgresql"

# randomly generate confluence postgresql password
node.set_unless['confluence']['local_database']['password'] = secure_password
node.save unless Chef::Config['solo']

# Assume we're running the crowd server locally
postgresql_connection_info = {:host => "localhost", :username => "postgres", :password => node['postgresql']['password']['postgres']}

postgresql_database_user 'confluence' do
  connection postgresql_connection_info
  password node['confluence']['local_database']['password']
  action :create
end

postgresql_database 'confluence' do
  connection postgresql_connection_info
  encoding 'UNICODE'
  owner 'postgres'
  action :create
end

postgresql_database_user 'confluence' do
  connection postgresql_connection_info
  database_name 'confluence'
  privileges [:all]
  action :grant
end

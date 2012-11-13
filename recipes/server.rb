#
# Cookbook Name:: confluence
# Recipe:: server
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

include_recipe "java::oracle"

execute "untar-confluence-tarball" do
  cwd node['confluence']['parentdir']
  command "tar zxf #{Chef::Config[:file_cache_path]}/#{node['confluence']['tarball']}"
  action :nothing
end

remote_file "#{Chef::Config[:file_cache_path]}/#{node['confluence']['tarball']}" do
  source node['confluence']['url']
  action :nothing
  notifies :run, resources(:execute => "untar-confluence-tarball"), :immediately
end

http_request "HEAD #{node['confluence']['url']}" do
  message ""
  url node['confluence']['url']
  action :head
  if File.exists?("#{Chef::Config[:file_cache_path]}/#{node['confluence']['tarball']}")
    headers "If-Modified-Since" => File.mtime("#{Chef::Config[:file_cache_path]}/#{node['confluence']['tarball']}").httpdate
  end
  notifies :create, resources(:remote_file => "#{Chef::Config[:file_cache_path]}/#{node['confluence']['tarball']}"), :immediately
end

user "confluence" do
  comment "Atlassian Confluence"
  home node['confluence']['workdir']
  system true
  action :create
end

directory node['confluence']['workdir'] do
  owner "confluence"
  group "confluence"
  mode 00755
  action :create
end

# Per https://confluence.atlassian.com/display/CONF43/Creating+a+Dedicated+User+Account+on+the+Operating+System+to+Run+Confluence
%w{logs temp work}.each do |d|
  directory "#{node['confluence']['installdir']}/#{d}" do
    owner "confluence"
    group "confluence"
    mode  00755
    action :create
  end
end

template "#{node['confluence']['installdir']}/confluence/WEB-INF/classes/confluence-init.properties" do
  source "confluence-init.properties.erb"
  owner "root"
  group "root"
  mode 00644
  variables(
    :confluence_workdir => node['confluence']['workdir']
  )
  action :create
  notifies :restart, "service[confluence]"
end

template "/etc/init.d/confluence" do
  source "confluence.init.erb"
  owner "root"
  group "root"
  mode  00755
  variables(
    :confluence_installdir => node['confluence']['installdir']
  )
  action :create
end

service "confluence" do
  supports :restart => true
  action [:enable, :start]
end

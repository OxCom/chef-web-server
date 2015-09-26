#
# Cookbook Name:: wstools
# Recipe:: nginx
#
# Copyright 2015, OxCom Inc.
#
# All rights reserved - Do Not Redistribute
# Nginx install

include_recipe 'nginx'

directory "/var/www" do
  owner 'root'
  group 'root'
  mode '0777'
  action :create
end

directory "/var/www/default" do
  owner 'root'
  group 'root'
  mode '0777'
  action :create
end


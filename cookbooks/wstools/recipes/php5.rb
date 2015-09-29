#
# Cookbook Name:: wstools
# Recipe:: php5
#
# Copyright 2015, PHP5
#
# All rights reserved - Do Not Redistribute
# Get PHP5.6 and fix php5-fpm service

service 'php5-fpm' do
  provider Chef::Provider::Service::Upstart
  supports :stop => true
  action [ :disable, :stop ]
end

include_recipe 'php5-fpm'
include_recipe 'php5-fpm::install'
include_recipe 'php5-fpm::create_user'
include_recipe 'php5-fpm::configure_pools'

package "php5-dev" do
  action :install
  options '--force-yes'
end

package "php5-common" do
  action :install
  options '--force-yes'
end

package "php5-xdebug" do
  action :install
  options '--force-yes'
end

package "php5-redis" do
  action :install
  options '--force-yes'
end

package "php5-memcache" do
  action :install
  options '--force-yes'
end

package "php5-mysql" do
  action :install
  options '--force-yes'
end

package "php5-mysqlnd" do
  action :install
  options '--force-yes'
end

package "php5-curl" do
  action :install
  options '--force-yes'
end

execute 'PEAR: install xhprof' do
  command 'sudo pecl install -f xhprof'
end

ruby_block 'Add xhprof for PHP5 modules' do
  block do
    open('/etc/php5/mods-available/xhprof.ini', 'w') do |f|
      f.puts "extension=xhprof.so"
    end
  end
  action :run
end

execute 'PEAR: install xhprof' do
  command 'sudo php5enmod xhprof'
end

service 'php5-fpm' do
  provider Chef::Provider::Service::Upstart
  supports :restart => true
  action [ :restart ]
end

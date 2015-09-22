#
# Cookbook Name:: wstools
# Recipe:: php5
#
# Copyright 2015, YOUR_COMPANY_NAME
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
end

package "php5-common" do
  action :install
end

package "php5-xdebug" do
  action :install
end

package "php5-redis" do
  action :install
end

package "php5-memcache" do
  action :install
end

package "php5-mysql" do
  action :install
end

package "php5-mysqlnd" do
  action :install
end

package "php5-curl" do
  action :install
end

execute 'PEAR: php.ini set up' do
  command 'sudo pear config-set php_ini /etc/php5/fpm/php.ini'
end

execute 'PEAR: install xhprof' do
  command 'sudo pecl install -f xhprof'
end

ruby_block 'reload_client_config' do
  block do
    if File.exist?('/etc/php5/fpm/conf.d/20-xhprof.ini')
      open('/etc/php5/fpm/conf.d/20-xhprof.ini', 'w') do |f|
        f.puts "extension=xhprof.so"
      end
    end
  end
  action :run
end

ruby_block 'reload_client_config' do
  block do
    if File.exist?('/etc/php5/cli/conf.d/20-xhprof.ini')
      open('/etc/php5/cli/conf.d/20-xhprof.ini', 'w') do |f|
        f.puts "extension=xhprof.so"
      end
    end
  end
  action :run
end


service 'php5-fpm' do
  provider Chef::Provider::Service::Upstart
  supports :restart => true
  action [ :restart ]
end

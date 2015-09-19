#
# Cookbook Name:: wstools
# Recipe:: php5repo
#
# Copyright 2015, OxCom Inc.
#
# All rights reserved - Do Not Redistribute
# Add PHP5.6 PPA

apt_repository 'php56' do
  uri 'http://ppa.launchpad.net/ondrej/php5-5.6/ubuntu'
  components ['main']
  distribution node['lsb']['codename']
  deb_src 'true'
end

package "python-software-properties" do
  action :install
end

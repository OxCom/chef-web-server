#
# Cookbook Name:: wstools
# Recipe:: npm
#
# Copyright 2015, OxCom Inc.
#
# All rights reserved - Do Not Redistribute
# Ruby Gems

# Before install gems we need to have 'ruby-devel' package

package "git-core" do
  action :install
end

package "curl" do
  action :install
end

package "zlib1g-dev" do
  action :install
end

package "build-essential" do
  action :install
end

package "libssl-dev" do
  action :install
end

package "libreadline-dev" do
  action :install
end

package "libyaml-dev" do
  action :install
end

package "libsqlite3-dev" do
  action :install
end

package "sqlite3" do
  action :install
end

package "libxml2-dev" do
  action :install
end

package "libxslt1-dev" do
  action :install
end

package "libcurl4-openssl-dev" do
  action :install
end

package "libgdbm-dev" do
  action :install
end

package "libncurses5-dev" do
  action :install
end

package "automake" do
  action :install
end

package "libtool" do
  action :install
end

package "bison" do
  action :install
end

package "libffi-dev" do
  action :install
end

if node["wstools"]["install_rvm"]
  execute 'Ruby: Set key' do
    command 'sudo gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3'
  end

  execute 'Ruby: Get stable RVM' do
    command 'curl -L https://get.rvm.io | sudo bash -s stable'
  end

  execute 'Ruby: install' do
    command 'sudo /usr/local/rvm/scripts/rvm install 2.2.3'
  end

  execute 'Ruby: use installed version' do
    command 'sudo /usr/local/rvm/scripts/rvm use 2.2.3 --default'
  end
end

package "ruby-dev" do
    action :install
end

gem_package "compass" do
  provider Chef::Provider::Package::Rubygems
  action :install
end

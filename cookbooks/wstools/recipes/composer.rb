#
# Cookbook Name:: wstools
# Recipe:: composer
#
# Copyright 2015, OxCom Inc.
#
# All rights reserved - Do Not Redistribute
# Composer


execute 'Composer: Get installer' do
  command 'curl -sS https://getcomposer.org/installer | sudo php'
end

execute 'Composer: Install global' do
  command 'sudo mv composer.phar /usr/local/bin/composer'
end

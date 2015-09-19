name             'php5-fpm'
maintainer       'Brian Stajkowski'
maintainer_email 'stajkowski'
license          'Apache Open License'
description      'Installs/Configures php5-fpm'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '0.4.5'

depends 'hostupgrade', ">= 0.1.3"

supports 'ubuntu', ">= 10.04"
supports 'debian', ">= 6.0"
supports 'centOS', ">= 6.5"
supports 'Redhat'
supports 'Fedora', ">= 20.0"

attribute 'php_fpm/install_php_modules',
          :display_name => "PHP5-FPM Install PHP Modules",
          :description => "Boolean value to indicate if additional php_modules should be installed.",
          :type => "string",
          :required => true,
          :recipes => [ 'php5_fpm::install' ],
          :default => "true"

attribute 'php_fpm/use_cookbook_repos',
          :display_name => "PHP5-FPM Use Cookbook Repos",
          :description => "Let the cookbook install repos for PHP5-FPM for earlier OS versions.",
          :type => "string",
          :required => true,
          :recipes => [ 'php5_fpm::install' ],
          :default => "true"

attribute 'php_fpm/run_update',
          :display_name => "PHP5-FPM Run Update",
          :description => "Let the install recipe run an update and upgrade.",
          :type => "string",
          :required => true,
          :recipes => [ 'php5_fpm::install' ],
          :default => "true"

attribute 'php_fpm/create_users',
          :display_name => "PHP5-FPM Create Users",
          :description => "Boolean value to indicate if users for pools should be added to the system.",
          :type => "string",
          :required => true,
          :recipes => [ 'php5_fpm::create_user' ],
          :default => "true"

attribute 'php_fpm/create_users',
          :display_name => "PHP5-FPM Create Users JSON",
          :description => "JSON value of users to add to the local system for pools.",
          :type => "string",
          :required => "recommended",
          :recipes => [ 'php5_fpm::create_user' ],
          :default => '{ "users":
	                        {
		                        "fpm_user": { "dir": "/base_path", "system": "true", "group": "fpm_group" }
	                        }
                        }'

attribute 'php_fpm/package',
          :display_name => "PHP5-FPM Package Name",
          :description => "Package value name determined by OS.",
          :type => "string",
          :required => true,
          :recipes => [ 'php5_fpm::install', 'php5_fpm:configure_pools', 'php5_fpm:configure_fpm' ],
          :default => "php5-fpm"

attribute 'php_fpm/base_path',
          :display_name => "PHP5-FPM Package Base Path",
          :description => "Base path for php5-fpm for installation of pools and configuration.",
          :type => "string",
          :required => true,
          :recipes => [ 'php5_fpm::install', 'php5_fpm:configure_pools', 'php5_fpm:configure_fpm' ],
          :default => "/etc/php5/fpm"

attribute 'php_fpm/conf_file',
          :display_name => "PHP5-FPM Configuration File Location",
          :description => "Base configuration file location and name.  This is platform specific.",
          :type => "string",
          :required => true,
          :recipes => [ 'php5_fpm::install', 'php5_fpm:configure_pools', 'php5_fpm:configure_fpm' ],
          :default => "php-fpm.conf"

attribute 'php_fpm/pools_path',
          :display_name => "PHP5-FPM Pools Directory Location",
          :description => "Pools configuration directory location.  This is platform specific.",
          :type => "string",
          :required => true,
          :recipes => [ 'php5_fpm::install', 'php5_fpm:configure_pools' ],
          :default => "pool.d"

attribute 'php_fpm/pools_include',
          :display_name => "PHP5-FPM Pool Include Path",
          :description => "Directory for php-fpm.conf to include pools directory.  This is platform specific.",
          :type => "string",
          :required => true,
          :recipes => [ 'php5_fpm::install', 'php5_fpm:configure_pools' ],
          :default => "pool.d/*.conf"

attribute 'php_fpm/php_modules',
          :display_name => "PHP5-FPM Additional PHP Modules",
          :description => "Additional modules to be installed, if enabled, for php.  This is platform specific.",
          :type => "array",
          :required => true,
          :recipes => [ 'php5_fpm::install' ],
          :default => [ 'php5-common', 'php5-mysql', 'php5-curl', 'php5-gd']
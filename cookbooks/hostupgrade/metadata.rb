name             'hostupgrade'
maintainer       'Brian Stajkowski'
maintainer_email 'stajkowski'
license          'Apache Open License'
description      'Updates and Upgrades Host'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '0.1.3'

supports 'ubuntu', ">= 10.04"
supports 'debian', ">= 6.0"
supports 'centOS', ">= 6.5"
supports 'Redhat'
supports 'Fedora', ">= 20.0"

attribute 'hostupgrade/update_system',
          :display_name => "System Updates",
          :description => "Check for system updates but does not trigger an upgrade.",
          :type => "string",
          :required => true,
          :recipes => [ 'hostupgrade::default' ],
          :default => "true"

attribute 'hostupgrade/upgrade_system',
          :display_name => "System Upgrades",
          :description => "Perform system upgrades.",
          :type => "string",
          :required => true,
          :recipes => [ 'hostupgrade::default' ],
          :default => "true"

attribute 'hostupgrade/first_time_only',
          :display_name => "Run First-Time",
          :description => "Perform system upgrades only on first-run",
          :type => "string",
          :required => true,
          :recipes => [ 'hostupgrade::default' ],
          :default => "true"
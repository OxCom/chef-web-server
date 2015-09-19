name             'wstools'
maintainer       'OxCom Inc.'
maintainer_email 'lancer.oxcom@gmail.com'
license          'All rights reserved'
description      'Installs/Configures web server tools'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '0.1.0'

depends "htop"
depends "nginx"
depends "php5-fpm"
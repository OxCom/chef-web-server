Web Developer Tools [![Build Status](https://travis-ci.org/OxCom/chef-web-server.svg?branch=master)](https://travis-ci.org/OxCom/chef-web-server)
==========
This soup made for [Chef](https://www.chef.io/chef/) and wasn't tested. So, please, be calm and remember that, this is private configuration for web servers. If you find any bug, just help me or make a fork and do your stuff.

Install Chef
========

``` wget https://www.opscode.com/chef/install.sh```

``` sudo bash install.sh ```


Start cook
========
``` sudo chef-solo -c config.rb -j config.json ```


Repository Directories
======================

This repository contains several directories, and each directory contains a README file that describes what it is for in greater detail, and how to use it for managing your systems with Chef.

* `cookbooks/` - Cookbooks with MAGIC!!!
* `data_bugs/` - Empty
* `environments/` - Store environments in .rb or .json in the repository.

`cookbooks/wstools` - this is our main cookbook  


Configuration
=============
Nope... ^_^

TODO:
=============
1. Move solo.rb and web.json to ENV folders (?)
2. Add Memcached Server
3. Add MySQL
4. Add extensions for PHP
5. Add configurations (NGINX, PHP,e.t.c)

PHP extensions:

* ImageMagic


How To:
=============

1. New Chef repo:

```
 wget http://github.com/opscode/chef-repo/tarball/master
 tar -zxf master 
 mv chef-chef-repo* chef-repo 
 rm master
```

2. Add cookbooks. You can install all of them and then you can use `tar -xvf`

```
knife cookbook site install COOKBOOK_NAME
```

or

```
 knife cookbook site download COOKBOOK_NAME 
 find . -maxdepth 1 -name '*.tar.gz' -exec tar -xvf '{}' -C cookbooks/ \;
```


P.S.
======================
© 1988 - 2015 by [OxCom](http://oxcom.me). All rights reserved.



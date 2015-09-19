PHP5-FPM Cookbook
=====
Adding pools can be done by way of LWRP provider or by modifying JSON directly in the attributes file or overriding the attributes through other methods, environments, roles, etc.  Usage of the receipes beyond ::install is optional and not
needed if using the LWRP provider.

When using the JSON option with recipes, if you do not wish to use a configuration value in the JSON attributes, you can simply set it to NOT_SET and it will not be included in the configuration file.  Additionally, you can add more
configuration values if they are missing, future proofing the template generation with JSON.

As of version 4.0, you can auto-calculate the procs and workers needed and define the percentage of resources the pool should consume on the server.  This allows for quick creation of php-fpm pools and not having
to perform the calculation yourself.  Please see the LWRP attributes below and the auto-calculation example, but the simplest explanation is the pm configuration will be determined by the calculation.  If the pm
type is set to static then the max_children will only be used.  If the type is dynamic, the auto-calculation will populate the additional pm configuration options but not the pm.max_requests, this will need to be set
manually.

>#### Supported Chef Versions
>Chef 12 and below
>#### Supported Platforms
>Debian(6.x+), Ubuntu(10.04+)
>CentOS(6.x+), RedHat, Fedora(20+)
>#### Tested Against
>Debian 6.x and above
>Ubuntu 10.04 and above
>CenOS 6.x and above
>Fedora 20
>#### Planned Improvements
>0.4.3 - Any additional bugs
>#### Required Cookbooks
>hostupgrade


#Attributes
_____
### php5-fpm::default

| Key                                | Type    | Description                                                                                                                           | Default                                                          |
|------------------------------------|---------|---------------------------------------------------------------------------------------------------------------------------------------|------------------------------------------------------------------|
| ["php_fpm"]["use_cookbook_repos"]  | Boolean | Use cookbook to install repos for earlier OS versions, ubuntu 10.04, centos 6.x, debian 6.x                                           | true                                                             |
| ["php_fpm"]["run_update"]          | Boolean | Run hostupgrade::upgrade. Will only run first-run by default; set ["hostupgrade"]["first_time_only"] to false if required every time. | true                                                             |
| ["php_fpm"]["install_php_modules"] | Boolean | Install Additional PHP Modules stated in ["php_fpm"]["php_modules"]                                                                   | false                                                            |
| ["php_fpm"]["php_modules"]         | Array   | List additional PHP Modules you wish to install.                                                                                      | ['php5-common','php5-mysql','php5-curl','php5-gd'] *OS Dependent |
| ["php_fpm"]["create_users"]        | Boolean | Configure Users. Must include recipe recipe[php5-fpm::create_user]                                                                    | true                                                             |
| ["php_fpm"]["users"]               | JSON    | Users/Directories to Add                                                                                                              | Attributes File                                                  |
| ["php_fpm"]["config"]              | JSON    | PHP-FPM.conf Configuration Values                                                                                                     | Attributes File                                                  |
| ["php_fpm"]["pools"]               | JSON    | pool.conf Configuration Values                                                                                                        | Attributes File                                                  |
| ["php_fpm"]["ubuntu1004_config"]   | JSON    | PHP-FPM.conf Configuration Values Ubuntu 10.04 Only                                                                                   | Attributes File                                                  |
| ["php_fpm"]["ubuntu1004_pools"]    | JSON    | pool.conf Configuration Values Ubuntu 10.04 Only                                                                                      | Attributes File                                                                 |

# Resource/Provider
______
## php5_fpm_pool

### Actions

* create
* modify
* delete

### Attribute Parameters

| Attribute                 | Type                                    | Description                                                                                      |
|---------------------------|-----------------------------------------|--------------------------------------------------------------------------------------------------|
| overwrite                 | True/False Default: false               | Determine if the pool configuration will be overwritten if it exists.                            |
| Base Pool                 |                                         |                                                                                                  |
| pool_name                 | String                                  | Name of the pool; it will also be used to name the pool file.                                    |
| pool_user                 | String Default: www-data                | Sets the user attribute in the pool conf file.                                                   |
| pool_group                | String Default: www-data                | Sets the group attribute in the pool conf file.                                                  |
| listen_address            | String Default: 127.0.0.1               | Sets the listen attribute in the pool conf file.                                                 |
| listen_port               | Integer Default: 9000                   | Sets the listen attribute in the pool conf file.                                                 |
| listen_allowed_clients    | String Default: nil                     | Sets the listen.allowed_clients attribute in the pool conf file.                                 |
| listen_owner              | String Default: nil                     | Sets the listen.owner attribute in the pool conf file.                                           |
| listen_group              | String Default: nil                     | Sets the listen.group attribute in the pool conf file.                                           |
| listen_mode               | String Default: nil                     | Sets the listen.mode attribute in the pool conf file.                                            |
| use_sockets               | Boolean Default: false                  | If set, this overrides IPv4 assignment for listen attribute in the pool conf file to use sockets |
| listen_socket             | String Default: nil                     | Sets the listen attribute in the pool conf file.(Requires: use_sockets true)                     |
| listen_backlog            | Integer Default: 65536                  | Sets the listen.backlog attribute in the pool conf file.                                         |
| PM Config                 |                                         |                                                                                                  |
| pm                        | String Default: dynamic                 | Sets the pm attribute in the pool conf file.                                                     |
| pm_max_children           | Integer Default: 10                     | Sets the pm.max_children attribute in the pool conf file.                                        |
| pm_start_servers          | Integer Default: 4                      | Sets the pm.start_servers attribute in the pool conf file.                                       |
| pm_min_spare_servers      | Integer Default: 2                      | Sets the pm.min_spare_servers attribute in the pool conf file.                                   |
| pm_max_spare_servers      | Integer Default: 6                      | Sets the pm.max_spare_servers attribute in the pool conf file.                                   |
| pm_process_idle_timeout   | String Default: 10s                     | Sets the pm.process_idle_timeout attribute in the pool conf file.                                |
| pm_max_requests           | Integer Default: 0                      | Sets the pm.max_requests attribute in the pool conf file.                                        |
| pm_status_path            | String Default: /status                 | Sets the pm.status_path attribute in the pool conf file.                                         |
| Ping                      |                                         |                                                                                                  |
| ping_path                 | String Default: /ping                   | Sets the ping.path attribute in the pool conf file.                                              |
| ping_response             | String Default: /pong                   | Sets the ping.response attribute in the pool conf file.                                          |
| Logging                   |                                         |                                                                                                  |
| access_format             | String Default: %R - %u %t \"%m %r\" %s | Sets the access.format attribute in the pool conf file.                                          |
| request_slowlog_timeout   | Integer Default: 0                      | Sets the request_slowlog_timeout attribute in the pool conf file.                                |
| request_terminate_timeout | Integer Default: 0                      | Sets the request_terminate_timeout attribute in the pool conf file.                              |
| access_log                | String Default: nil                     | Sets the access.log attribute in the pool conf file.                                             |
| slow_log                  | String Default: nil                     | Sets the slowlog attribute in the pool conf file.                                                |
| MISC                      |                                         |                                                                                                  |
| chdir                     | String Default: /                       | Sets the chdir attribute in the pool conf file.                                                  |
| chroot                    | String Default: nil                     | Sets the chroot attribute in the pool conf file.                                                 |
| catch_workers_output      | String yes/no Default: no               | Sets the catch_workers_output attribute in the pool conf file.                                   |
| security_limit_extensions | String Default: .php                    | Sets the security.limit_extensions attribute in the pool conf file.                              |
| rlimit_files              | Integer Default: nil                    | Sets the rlimit_files attribute in the pool conf file.                                           |
| rlimit_core               | Integer Default: nil                    | Sets the rlimit_core attribute in the pool conf file.                                            |
| PHP Conf Flags/Values     |                                         |                                                                                                  |
| php_ini_flags             | Hash Default: nil                       | Sets the php_flag[] attribute in the pool conf file.                                             |
| php_ini_values            | Hash Default: nil                       | Sets the php_value[] attribute in the pool conf file.                                            |
| php_ini_admin_flags       | Hash Default: nil                       | Sets the php_admin_flag[] attribute in the pool conf file.                                       |
| php_ini_admin_values      | Hash Default: nil                       | Sets the php_admin_value[] attribute in the pool conf file.                                      |
| Environment Vars          |                                         |                                                                                                  |
| env_variables             | Hash Default: nil                       | Sets the env[] attribute in the pool conf file.                                                  |
| Auto-Calculate            |                                         |                                                                                                  |
| auto_calculate            | String Default: false                   | Enables auto-calculation of php-fpm pool resources.                                              |
| percent_share             | Integer 1 - 100 Default: 100            | Defines the percentage share of the server resources the pool can consume.                       |
| round_down                | String Default: false                   | Round-up is defined by default; set round_down to trye to go the other way.                      |

### Example

```
php5_fpm_pool "example" do
    pool_user "www-data"
    pool_group "www-data"
    listen_address "127.0.0.1"
    listen_port 8000
    listen_allowed_clients "127.0.0.1"
    listen_owner "nobody"
    listen_group "nobody"
    listen_mode "0666"
    php_ini_flags (
                    { "display_errors" => "off", "log_errors" => "on"}
                  )
    php_ini_values (
                      { "sendmail_path" => "/usr/sbin/sendmail -t -i -f www@my.domain.com", "memory_limit" => "32M"}
                  )
    overwrite true
    action :create
    notifies :restart, "service[#{node["php_fpm"]["package"]}]", :delayed
end
```

```
php5_fpm_pool "example" do
    pool_user "fpm_user"
    pool_group "fpm_group"
    listen_allowed_clients "127.0.0.1"
    pm_max_children 30
    pm_start_servers 10
    pm_min_spare_servers 5
    pm_max_spare_servers 10
    pm_process_idle_timeout "30s"
    pm_max_requests 1000
    pm_status_path "/mystatus"
    ping_path "/myping"
    ping_response "/myresponse"
    php_ini_flags (
                      { "display_errors" => "on", "log_errors" => "off"}
                  )
    php_ini_values (
                       { "sendmail_path" => "/usr/sbin/sendmail -t -i -f www@my.yourdomain.com", "memory_limit" => "16M"}
                   )
    action :modify
    notifies :restart, "service[#{node["php_fpm"]["packag"]}]", :delayed
end
```

### Auto-Calculate Example

```
php5_fpm_pool "example" do
    pool_user "fpm_user"
    pool_group "fpm_group"
    listen_allowed_clients "127.0.0.1"
    auto_calculate true
    percent_share 80
    round_down true
    pm_process_idle_timeout "30s"
    pm_max_requests 1000
    pm_status_path "/mystatus"
    ping_path "/myping"
    ping_response "/myresponse"
    php_ini_flags (
                      { "display_errors" => "on", "log_errors" => "off"}
                  )
    php_ini_values (
                       { "sendmail_path" => "/usr/sbin/sendmail -t -i -f www@my.yourdomain.com", "memory_limit" => "16M"}
                   )
    action :modify
    notifies :restart, "service[#{node["php_fpm"]["package"]}]", :delayed
end
```

### Sockets Example

```
php5_fpm_pool "example3sockets" do
    pool_user "fpm_user"
    pool_group "fpm_group"
    use_sockets true
    listen_socket "/var/run/phpfpm_example.sock"
    listen_owner "fpm_user"
    listen_group "fpm_group"
    listen_mode "0660"
    overwrite true
    action :create
    notifies :restart, "service[#{node["php_fpm"]["package"]}]", :delayed
end
```

# Recipe Usage

### php-fpm::install (required)

Install PHP5-FPM. Include `php5-fpm::install` in your node's `run_list`:

```json
{
  "name":"my_node",
  "run_list": [
    "recipe[php5-fpm::install]"
  ]
}
```

### php5-fpm::create_user (optional)

This will create users and directories for use with pools. Include `php5-fpm::create_user` in your node's `run_list`:

```json
{
  "name":"my_node",
  "run_list": [
    "recipe[php5-fpm::create_user]"
  ]
}
```

### php5-fpm::configure_pools (optional)

This will create pools based on JSON attributes.  Not needed if you are using the LWRP provider. Include `php5-fpm::configure_pools` in your node's `run_list`:

```json
{
  "name":"my_node",
  "run_list": [
    "recipe[php5-fpm::configure_pools]"
  ]
}
```

### php5-fpm::example_pool (optional)

Example on how to use the LWRP provider.  This is not a required recipe but include `php5-fpm::example_pool` in your node's `run_list` if you wish to try the example:

```json
{
  "name":"my_node",
  "run_list": [
    "recipe[php5-fpm::example_pool]"
  ]
}
```

# License and Authors
___
Authors: Brian Stajkowski

Copyright 2014 Brian Stajkowski

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
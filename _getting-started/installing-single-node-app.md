---
title: Installing Single Node Example
order: 50
---

## Single node app scenario
This article will cover deployment of single node app example. This assembly template contains one node on which we install/deploy: mysql database, php and apache web server. This should be sufficient enough to have simple environment where we have all building blocks for creating and maintaining php web applications. Simple diagram looks like this:

![single_node_app]({{site.assetsBaseDir}}/img/single_node_app.jpeg "Single Node App Diagram")

## Installing service and component modules

Before going further, we need to make sure that we have appropriate service and component modules loaded on our DTK Server. We can do this using following command:

{% highlight bash linenos %}
dtk:/service-module>install test/examples
Auto-importing missing module(s)
Using component module 'puppetlabs:stdlib'
Using component module 'puppetlabs:vcsrepo'
Using component module 'thias:php'
Using component module 'puppetlabs:mysql'
Using component module 'puppetlabs:apache'
Importing component module 'nanliu:staging' ... Done.
Importing component module 'puppetlabs:concat' ... Done.
Importing component module 'dtk-examples:php_app' ... Done.
Resuming DTK Network import for service_module 'test/examples' ... Done
module_directory: /home/dtk17-client/dtk/service_modules/test/examples
{% endhighlight %}

Thats it. When importing test/examples service module, all dependency component modules will be automatically imported and you don't have to worry about installing each of them.

## Using single node app assembly template

Now that we have test/examples service module, we can find single_node_app assembly template in it. Then, we need to stage it in order to create instance (service) which will be our example of deployed environment. To do that you need to do following:

{% highlight bash linenos %}
dtk:/>cd service-module
dtk:/service-module>cd test:examples
dtk:/service-module/test:examples>cd assembly
dtk:/service-module/test:examples/assembly>ls
 
+------------+--------------------+-------+-----------------------------------------+
| ID         | ASSEMBLY NAME      | NODES | DESCRIPTION                             |
+------------+--------------------+-------+-----------------------------------------+
| 2149219278 | multi_node_app_db  | 2     | apache-php-mysql example on multi node  |
| 2149219103 | single_node_app_db | 1     | apache-php-mysql example on single node |
+------------+--------------------+-------+-----------------------------------------+
2 rows in set
1 row in set
dtk:/service-module/test:examples/assembly>cd single_node_app_db
dtk:/service-module/test:examples/assembly/single_node_app_db>stage
---
new_service_instance:
  name: examples-single_node_app_db
  id: 2149219117
{% endhighlight %}

Staged instance (in future text we will refer it as service), can be found inside service context. Among many things, we can examine details of our service (list nodes, list components) in following way:

{% highlight bash linenos %}
dtk:/service>cd examples-single_node_app_db
dtk:/service/examples-single_node_app_db>list-nodes
+------------+-------+-------------+----------+--------+-----------+--------------------------------------------+
| ID         | NAME  | INSTANCE ID | SIZE     | OS     | OP STATUS | DNS NAME                                   |
+------------+-------+-------------+----------+--------+-----------+--------------------------------------------+
| 2149223599 | test1 | i-a8a21558  | t1.micro | ubuntu | running   |                                            |
+------------+-------+-------------+----------+--------+-----------+--------------------------------------------+
1 row in set
dtk:/service/examples-single_node_app_db>list-components
+------------+--------------------------+
| ID         | NAME                     |
+------------+--------------------------+
| 2149223604 | test1/apache             |
| 2149223606 | test1/mysql::db[testdb]  |
| 2149223607 | test1/mysql::server      |
| 2149223721 | test1/php::module[mysql] |
| 2149223605 | test1/php::module[php5]  |
| 2149223603 | test1/php_app            |
+------------+--------------------------+
6 rows in set
{% endhighlight %}

As it can be seen from the output of list-nodes, we have one node called test1 which is t1.micro AMI (Amazon Machine Image) which already has OS ubuntu. From the output of list-components, we can see that there are 4 components on test1 node. Those components are:

*   test1/apache (this component originates from apache component module and underneath it is main Puppet Class defined in init.pp file)

*   test1/mysql::db[testdb] (this component originates from mysql component module and underneath it is Puppet Definition: mysql::db. Since it is Puppet Definition, it receives standard parameter "name" which is in this case: testdb and this represents name of the database that will be created)

*   test1/mysql::server (this component originates from mysql component module and underneath it is Puppet Class: mysql::server)

*   test1/php::module[mysql] (this component originates from php component module and underneath it is Puppet Definition: php::module[mysql]. Since it is Puppet Definition, it receives standard parameter "name" which is in this case: mysql and this represents name of the module that will be installed)

*   test1/php::module[php5] (this component originates from php component module and underneath it is Puppet Definition: php::module[php5]. Since it is Puppet Definition, it receives standard parameter "name" which is in this case: php5 and this represents name of the module that will be installed)

*   test1/php_app (this component originates from php_app component module and underneath it is main Puppet class defined in init.pp file. This component is used for git cloning sample php script and deploying it on apache web server. Example php script checks connectivity to MySQL database and prints php info)

It is also worth checking deployment workflow which defines exact way in which this service will be converged. This can be found in output of workflow-info command:

{% highlight bash linenos %}
dtk:/service/examples-single_node_app_db>workflow-info
---
subtask_order: sequential
subtasks:
- node: test1
  ordered_components:
  - mysql::server
  - mysql::db[testdb]
  - apache
  - php::module[php5]
  - php::module[mysql]
  - php_app
{% endhighlight %}

Workflow info output is in YAML format. We have node test1, in this node we have following order of components deployment: mysql::server, mysql::db[testdb], apache, php::module[php5], php::module[mysql], php_app
After we examined details of our service, we are now ready to deploy it. This is done using converge command:

{% highlight bash linenos %}
dtk:/service/examples-single_node_app_db>converge
task_id: 2149219267
dtk:/service/examples-single_node_app_db>task-status
+------------------------+-----------+-------+----------+-------------------+----------+
| TASK TYPE              | STATUS    | NODE  | DURATION | STARTED AT        | ENDED AT |
+------------------------+-----------+-------+----------+-------------------+----------+
| assembly_converge      | executing |       |          | 11:22:23 05/03/15 |          |
|   1 create_node        | executing | test1 |          | 11:22:23 05/03/15 |          |
|   2 configure_nodes    |           |       |          |                   |          |
|     2.1 configure_node |           | test1 |          |                   |          |
+------------------------+-----------+-------+----------+-------------------+----------+
4 rows in set
{% endhighlight %}

Every converge contains multiple tasks. Root task (task_id from above) is called assembly_converge. This task has its own subtasks called: create_node (this task creates new AMI instance on AWS) and configure_nodes (this task contains list of subtasks, in this case there is only one subtask called configure_node, which does the actual deployment of components on the node). It will take couple of minutes to successfully converge this service. We can examine the result of execution by using task-status command again (or use task-status --wait command to interactively get refreshed status of the execution):

{% highlight bash linenos %}
dtk:/service/examples-single_node_app_db>task-status
+------------------------+-----------+-------+----------+-------------------+-------------------+
| TASK TYPE              | STATUS    | NODE  | DURATION | STARTED AT        | ENDED AT          |
+------------------------+-----------+-------+----------+-------------------+-------------------+
| assembly_converge      | succeeded |       | 302.1s   | 11:22:23 05/03/15 | 11:27:25 05/03/15 |
|   1 create_node        | succeeded | test1 | 64.0s    | 11:22:23 05/03/15 | 11:23:27 05/03/15 |
|   2 configure_nodes    | succeeded |       | 227.1s   | 11:23:38 05/03/15 | 11:27:25 05/03/15 |
|     2.1 configure_node | succeeded | test1 | 227.1s   | 11:23:38 05/03/15 | 11:27:25 05/03/15 |
+------------------------+-----------+-------+----------+-------------------+-------------------+
4 rows in set
{% endhighlight %}

As it can be seen, all tasks have been executed successfully. We can see other stats of task execution like: duration, started at, ended at.

## Examining deployed single node app scenario
Now that we successfully converged service, it is time to check if environment was deployed successfully and all needed services are up and running (in our case we expect to have apache web server and mysql database running). We can examine this in numerous ways and here are some of them:

**Using utils commands:**
If you enter in utils sub-context, you can see numerous commands available like: get-netstats, get-ps, tail, grep..etc. We will use get-netstats (to check listening ports) and get-ps (to check unix processes) on deployed environment:

{% highlight bash linenos %}
dtk:/service/examples-single_node_app_db/utils>get-netstats
+-----------+------------+---------------+------+----------+
| NODE NAME | NODE ID    | LOCAL ADDRESS | PORT | PROTOCOL |
+-----------+------------+---------------+------+----------+
| test1     | 2149219118 | ::            | 22   | tcp6     |
|           |            | 0.0.0.0       | 22   | tcp      |
|           |            | 0.0.0.0       | 68   | udp      |
|           |            | 0.0.0.0       | 80   | tcp      |
|           |            | 127.0.0.1     | 3306 | tcp      |
+-----------+------------+---------------+------+----------+
5 rows in set
dtk:/service/examples-single_node_app_db/utils>get-ps
+-----------+------------+----------+------+------------+-----------------------------------------------------------------+
| NODE NAME | NODE ID    | UID      | PID  | START TIME | COMMAND                                                         |
+-----------+------------+----------+------+------------+-----------------------------------------------------------------+
| test1     | 2149219118 | root     | 1    | 11:22      | /sbin/init                                                      |
| test1     | 2149219118 | root     | 266  | 11:23      | upstart-udev-bridge --daemon                                    |
| test1     | 2149219118 | root     | 268  | 11:23      | /sbin/udevd --daemon                                            |
| test1     | 2149219118 | root     | 339  | 11:23      | /sbin/udevd --daemon                                            |
| test1     | 2149219118 | root     | 340  | 11:23      | /sbin/udevd --daemon                                            |
| test1     | 2149219118 | root     | 393  | 11:23      | upstart-socket-bridge --daemon                                  |
| test1     | 2149219118 | root     | 453  | 11:23      | dhclient3 -e IF_METRIC=100 -pf /var/run/dhclient.eth0.pid -l... |
| test1     | 2149219118 | root     | 554  | 11:23      | /usr/sbin/sshd -D                                               |
| test1     | 2149219118 | 102      | 568  | 11:23      | dbus-daemon --system --fork --activation=upstart                |
| test1     | 2149219118 | syslog   | 572  | 11:23      | rsyslogd -c5                                                    |
| test1     | 2149219118 | mysql    | 5771 | 11:26      | /usr/sbin/mysqld                                                |
| test1     | 2149219118 | root     | 6751 | 11:27      | /usr/sbin/apache2 -k start                                      |
| test1     | 2149219118 | www-data | 6753 | 11:27      | /usr/sbin/apache2 -k start                                      |
| test1     | 2149219118 | www-data | 6754 | 11:27      | /usr/sbin/apache2 -k start                                      |
| test1     | 2149219118 | www-data | 6755 | 11:27      | /usr/sbin/apache2 -k start                                      |
| test1     | 2149219118 | root     | 6829 | 11:46      | ps -ef                                                          |
| test1     | 2149219118 | root     | 715  | 11:23      | /sbin/getty -8 38400 tty4                                       |
| test1     | 2149219118 | root     | 721  | 11:23      | /sbin/getty -8 38400 tty5                                       |
| test1     | 2149219118 | root     | 733  | 11:23      | /sbin/getty -8 38400 tty2                                       |
| test1     | 2149219118 | root     | 737  | 11:23      | /sbin/getty -8 38400 tty3                                       |
| test1     | 2149219118 | root     | 739  | 11:23      | /sbin/getty -8 38400 tty6                                       |
| test1     | 2149219118 | root     | 743  | 11:23      | acpid -c /etc/acpi/events -s /var/run/acpid.socket              |
| test1     | 2149219118 | root     | 747  | 11:23      | cron                                                            |
| test1     | 2149219118 | daemon   | 748  | 11:23      | atd                                                             |
| test1     | 2149219118 | whoopsie | 788  | 11:23      | whoopsie                                                        |
| test1     | 2149219118 | root     | 887  | 11:23      | /sbin/getty -8 38400 tty1                                       |
+-----------+------------+----------+------+------------+-----------------------------------------------------------------+
27 rows in set
{% endhighlight %}

Output of these commands is pretty self-explanatory but in nutshell it gives us: list of listening ports (for our scenario, it is important that ports: 80 (apache) and 3306 (mysql) are listening), list of unix processes (for our scenario, we can see that processes for mysql (UID: mysql) and apache (UID: www-data)) are up and running

**Checking the root webpage of this environment to make sure that apache web server is running:**
First, we need to get ec2 public DNS for test1 node and we can get this info from output of list-nodes command:

{% highlight bash linenos %}
dtk:/service/examples-single_node_app_db>list-nodes
+------------+-------+-------------+----------+--------+-----------+--------------------------------------------+
| ID         | NAME  | INSTANCE ID | SIZE     | OS     | OP STATUS | DNS NAME                                   |
+------------+-------+-------------+----------+--------+-----------+--------------------------------------------+
| 2149219118 | test1 | i-909f3360  | t1.micro | ubuntu | running   | ec2-54-211-140-115.compute-1.amazonaws.com |
+------------+-------+-------------+----------+--------+-----------+--------------------------------------------+
1 row in set
{% endhighlight %}

If we paste DNS_NAME to browser, we should get this:
![single_node_app_web]({{site.assetsBaseDir}}/img/single_node_app_web_1.png "Single node app web")

If we check DNS_NAME/test.php we should get this:
![single_node_app_web_2]({{site.assetsBaseDir}}/img/single_node_app_web_2.png "Single node app web 2")

**SSH to node and do any kind of examination on machine directly:**
Finally, for advanced verification and checking more complicated environments, we can always ssh from our DTK Client to the node itself and do any examination. This can be done using following set of commands: grant-access, list-ssh-keys, ssh, revoke-access. This is the process of doing it:

{% highlight bash linenos %}
dtk:/service/examples-single_node_app_db>grant-access ubuntu testkey
Access to system user 'ubuntu' has been granted for 'testkey' (test1)
dtk:/service/examples-single_node_app_db>list-ssh-access
+-----------+-------------+----------+
| NODE NAME | SYSTEM USER | KEY NAME |
+-----------+-------------+----------+
| test1     | ubuntu      | testkey  |
+-----------+-------------+----------+
1 row in set
dtk:/service/examples-single_node_app_db>cd test1
dtk:/service/examples-single_node_app_db/test1>ssh ubuntu
You are entering SSH terminal (ubuntu@ec2-54-211-140-115.compute-1.amazonaws.com) ...
Warning: Permanently added 'ec2-54-163-156-50.compute-1.amazonaws.com,10.158.82.6' (ECDSA) to the list of known hosts.
Welcome to Ubuntu 12.04.5 LTS (GNU/Linux 3.2.0-76-virtual x86_64)
 
ubuntu@ip-10-158-82-6:~$ php -v
PHP 5.3.10-1ubuntu3.16 with Suhosin-Patch (cli) (built: Feb 13 2015 20:15:04)
Copyright (c) 1997-2012 The PHP Group
Zend Engine v2.3.0, Copyright (c) 1998-2012 Zend Technologies
ubuntu@ip-10-158-82-6:~$
ubuntu@ip-10-158-82-6:~$ apache2 -v
Server version: Apache/2.2.22 (Ubuntu)
Server built:   Jul 22 2014 14:35:32
ubuntu@ip-10-158-82-6:~$
ubuntu@ip-10-158-82-6:~$ mysql --version
mysql  Ver 14.14 Distrib 5.5.41, for debian-linux-gnu (x86_64) using readline 6.2
ubuntu@ip-10-158-82-6:~$
ubuntu@ip-10-158-82-6:~$ mysql --host=localhost --user=user --password=password testdb
Welcome to the MySQL monitor.  Commands end with ; or \g.
Your MySQL connection idp is 65
Server version: 5.5.41-0ubuntu0.12.04.1 (Ubuntu)
Copyright (c) 2000, 2014, Oracle and/or its affiliates. All rights reserved.
Oracle is a registered trademark of Oracle Corporation and/or its
affiliates. Other names may be trademarks of their respective
owners.
Type 'help;' or '\h' for help. Type '\c' to clear the current input statement.
mysql>
ubuntu@ip-10-158-82-6:~$
ubuntu@ip-10-158-82-6:~$ exit
logout
Connection to ec2-54-211-140-115.compute-1.amazonaws.com closed.
You are leaving SSH terminal, and returning to DTK Shell ...
dtk:/service/examples-single_node_app_db/test1>
dtk:/service/examples-single_node_app_db/test1>cd ..
dtk:/service/examples-single_node_app_db>revoke-access ubuntu testkey
Access for system user 'ubuntu' has been revoked (test1)
{% endhighlight %}

First, we need to grant access to test1 node and this is done using command: **grant-access USER-ACCOUNT PUB-KEY-NAME** command. We can examine list of ssh accesses that are currently available with **list-ssh-keys** command. To test if access really exists to test1 node, we enter into test1 node sub-context and execute command **ssh USER-ACCOUNT** . When we are logged in into test1 node, we can perform checks for mysql, apache and php like it is done in this example to make sure that all these components are up and running. Finally, we exit from test1 node back to the DTK client shell and there we can revoke access if no longed needed using command: **revoke-access USER-ACCOUNT PUB-KEY-NAME**.
Thats it! We have fully functional LAMP (linux/apache/mysql/php) environment on single node. This environment is now ready for some real usage.
---
title: 5 Minute Quickstart
order: 20
---

# Dtk 5 Minute Quickstart

## Prerequisities
In order to start using Dtk, there are following prerequisities:

### AWS Account and EC2 instance
User needs to create AWS account because most provisioning done via Dtk will be on AWS instances. For more info, please check: <a href="https://aws.amazon.com/account" target="_blank">aws-account</a>

Next thing is to start your own EC2 instance on AWS which will be instance where Dtk server will be installed

### Docker
User needs to install Docker because Dtk Server and Dtk Arbiter are running inside docker container. For more info on how to install Docker, please check: <a href="https://docs.docker.com/engine/installation" target="_blank">docker-installation</a>

## Quick install
Having all prerequisites fulfilled, we will first install Dtk server. In order to do that, login to your AWS instance and pull latest docker images for dtk-server and dtk-arbiter from Docker Hub:

{% highlight bash linenos %}
~$ docker pull getdtk/dtk-server
~$ docker pull getdtk/dtk-arbiter
{% endhighlight %}

Next, you need to create dtk.config file which will be used for running both server and arbiter. 

First, create directory which will serve as mounted host volume for your containers
{% highlight bash linenos %}
~$ mkdir dtk
~$ cd dtk
~/dtk$
{% endhighlight %}

Next, create configuration file called: dtk.config inside directory from above. Add following content in dtk.config file:
{% highlight bash linenos %}
USERNAME=<USERNAME>
PASSWORD=<PASSWORD>
PUBLIC_ADDRESS=<PUBLIC_ADDRESS>
{% endhighlight %}

USERNAME and PASSWORD are credentials which will be used to connect to your DTK Server instance. PUBLIC_ADDRESS is actually an address of your instance where DTK Server is installed (hint: ec2 public dns).

Now we can move on to the actual installation of DTK Server using command:
{% highlight bash linenos %}
\curl -sSL https://getserver.dtk.io | bash -s <DTK_CONFIG_DIRECTORY>
{% endhighlight %}

In this example, that is:
{% highlight bash linenos %}
\curl -sSL https://getserver.dtk.io | bash -s /home/docker-client/dtk
{% endhighlight %}

That's it. You have your Dtk server up and running. Next thing to do is to install Dtk client that we will connect to this Dtk server instance. You can install Dtk client on any machine that will have http access towards the Dtk server. If you are installing Dtk client on different machine from Dtk server (which is the usual case), you will need dtk.config file again. Create dtk.config file in any directory you want, populate it with SAME values you used in dtk.config for Dtk server and run following command:

{% highlight bash linenos %}
\curl -sSL https://getclient.dtk.io | bash -s <DTK_CONFIG_DIRECTORY>
{% endhighlight %}

In this example, assuming that dtk.config is located in /dtk that is:
{% highlight bash linenos %}
\curl -sSL https://getclient.dtk.io | bash -s /dtk/
This script will do the following:

* Install the dtk-client gem
* Genereate an SSH keypair for the selected user (if it does not exist)
* Genereate dtk-client configuration files

Installing dtk-client gem
1 gem installed
{% endhighlight %}

Dtk client also has its own ~/dtk directory which will be generated on your home directory and it contains generated client configuration. You are now able to login using Dtk client for the first time and connect to your Dtk Server instance:

{% highlight bash linenos %}
~$ dtk
[INFO] Processing ...
Do you have DTK catalog credentials? (yes|no)
no
[INFO] SSH key '...' added successfully!
NAME
    dtk - DTK CLI tool

SYNOPSIS
    dtk [global options] command [command options] [arguments...]

VERSION
    0.10.0.2

GLOBAL OPTIONS
    --help    - Show this message
    --version - Display the program version

COMMANDS
    help    - Shows a list of commands or help for one command
    module  - Subcommands for interacting with DTK modules
    service - Subcommands for creating and interacting with DTK service instances
{% endhighlight %}

## Target setup
Now that you have Dtk up and running, first thing you need to do is to create target. You can think of a target as initial VPC (Virtual Private Cloud) infrastructure that needs to be set on AWS so user would be able to use Dtk to provision new instances on AWS. In order to create target, you need to have VPC already created on AWS. For more information on how to create VPC, check: http://docs.aws.amazon.com/AmazonVPC/latest/GettingStartedGuide/getting-started-create-vpc.html

To be able to configure and deploy anything via Dtk, we need to install modules. Modules are installed on Dtk server and cloned on local filesystem where Dtk client resides. Now is a good time to create special directory where installed modules will be cloned

{% highlight bash linenos %}
~$ mkdir modules
{% endhighlight %}

Next thing to do is to install target related module:

{% highlight bash linenos %}
~$ mkdir modules/target
~$ cd modules/target
~/modules/target$ dtk module install -v 1.0.0 aws/network
[INFO] Auto-importing dependencies
Importing module 'aws:ec2' ... [INFO] Done.
Importing module 'aws:identity_aws' ... [INFO] Done.
Importing module 'aws:image_aws' ... [INFO] Done.
Importing module 'aws:network_aws' ... [INFO] Done.
[INFO] Successfully imported 'aws:network' version 1.0.0

~/modules/target$ dtk module list-assemblies
+------------+---------------+-------+-------------+
| ID         | ASSEMBLY NAME | NODES | DESCRIPTION |
+------------+---------------+-------+-------------+
| 2147485655 | target        | 0     |             |
+------------+---------------+-------+-------------+
{% endhighlight %}

Now that we have target related module installed, it is time to create new target:

First, we will stage new target
{% highlight bash linenos %}
~/modules/target$ dtk service stage --target target
[INFO] Service instance 'network-target' has been created. In order to work with service instance, please navigate to: /home/docker-client/dtk/service/network-target
{% endhighlight %}

After staging target, we need to set required attributes for staged target
{% highlight bash linenos %}
~/modules/target$ cd ~/dtk/service/network-target
~/dtk/service/network-target$ dtk service set-required-attributes

Please fill in missing data.
Please enter identity_aws::credentials/aws_access_key_id [STRING]:
: <AWS_ACCESS_KEY_ID>
Please enter identity_aws::credentials/aws_secret_access_key [STRING]:
: <AWS_SECRET_ACCESS_KEY>
Please enter network_aws::vpc[vpc1]/default_keypair [STRING]:
: <DEFAULT_KEYPAIR>
--------------------------------- DATA ---------------------------------
identity_aws::credentials/aws_access_key_id : <AWS_ACCESS_KEY_ID>
identity_aws::credentials/aws_secret_access_key : <AWS_SECRET_ACCESS_KEY>
network_aws::vpc[vpc1]/default_keypair : <DEFAULT_KEYPAIR>
------------------------------------------------------------------------
Is provided information ok? (yes|no) yes
{% endhighlight %}

There are multiple scenarios when configuring target (this will be discussed in Dtk documentation) but the most straghtforward one is to setup target in same vpc where your Dtk server instance resides. To do that, no additional configuration is needed. Therefore, next step is to converge target

{% highlight bash linenos %}
~/dtk/service/network-target$ dtk service converge
{% endhighlight %}

If converge passed successfully, that means that we are ready to provision assembly templates in newly created target that actually points to SAME vpc, subnet and security group where your Dtk Server instance resides.

## Module installation and service provisioning
In order to show how provisioning works via Dtk, we will use basic assembly template example that deploys wordpress on nginx web server using mysql as database provider

In order to do that, we need to install dtk-example/wordpress module:
{% highlight bash linenos %}
~$ mkdir modules/wordpress
~$ cd modules/wordpress
~/modules/wordpress$ dtk module install -v 1.0.0 dtk-examples/wordpress
[INFO] Auto-importing dependencies
Using module 'aws:ec2'
Importing module 'puppetlabs:mysql' ... [INFO] Done.
Importing module 'puppetlabs:stdlib' ... [INFO] Done.
Importing module 'nanliu:staging' ... [INFO] Done.
Importing module 'dtk-examples:wordpress' ... [INFO] Done.
Importing module 'puppetlabs:concat' ... [INFO] Done.
Importing module 'puppetlabs:apt' ... [INFO] Done.
Importing module 'puppet:nginx' ... [INFO] Done.
Using module 'puppetlabs:concat' version: master
[INFO] Done.
[INFO] Successfully imported 'dtk-examples:wordpress' version 1.0.0
{% endhighlight %}

Now that we have module installed, next thing is to stage assembly template from that module. We can do that using following command:
{% highlight bash linenos %}
~/modules/wordpress$ dtk service stage
[INFO] Service instance 'wordpress-wordpress_single_node' has been created. In order to work with service instance, please navigate to: /home/docker-client/dtk/service/wordpress-wordpress_single_node
{% endhighlight %}

Next, we need to position to service instance directory, set required attributes and converge service instance:
{% highlight bash linenos %}
~/modules/wordpress$ cd ~/dtk/service/wordpress-wordpress_single_node
~/dtk/service/wordpress-wordpress_single_node$ dtk service set-required-attributes

Please fill in missing data.
Please enter wordpress/image (Logical term describing the image) [STRING]:
: trusty_hvm
--------------------------------- DATA ---------------------------------
wordpress/image (Logical term describing the image) : trusty_hvm
------------------------------------------------------------------------
Is provided information ok? (yes|no) yes
~/dtk/service/wordpress-wordpress_single_node$ dtk service converge
---
task_id: 2147493187
~/dtk/service/wordpress-wordpress_single_node$ dtk service task-status
+---------------------------------+-----------+-----------+----------+-------------------+-------------------+
| TASK TYPE                       | STATUS    | NODE      | DURATION | STARTED AT        | ENDED AT          |
+---------------------------------+-----------+-----------+----------+-------------------+-------------------+
| assembly_converge               | executing |           |          | 10:59:48 11/10/16 |                   |
|   1 create_node                 | succeeded | wordpress | 89.3s    | 10:59:48 11/10/16 | 11:01:18 11/10/16 |
|   2 mysql install               | executing |           |          | 11:01:18 11/10/16 |                   |
|     2.1 configure_node          | executing | wordpress |          | 11:01:18 11/10/16 |                   |
|   3 nginx and php install       |           |           |          |                   |                   |
|     3.1 configure_node          |           | wordpress |          |                   |                   |
|   4 wordpress install and setup |           |           |          |                   |                   |
|     4.1 configure_node          |           | wordpress |          |                   |                   |
+---------------------------------+-----------+-----------+----------+-------------------+-------------------+
8 rows in set
~/dtk/service/wordpress-wordpress_single_node$ dtk service task-status
+---------------------------------+-----------+-----------+----------+-------------------+-------------------+
| TASK TYPE                       | STATUS    | NODE      | DURATION | STARTED AT        | ENDED AT          |
+---------------------------------+-----------+-----------+----------+-------------------+-------------------+
| assembly_converge               | executing |           |          | 10:59:48 11/10/16 |                   |
|   1 create_node                 | succeeded | wordpress | 89.3s    | 10:59:48 11/10/16 | 11:01:18 11/10/16 |
|   2 mysql install               | succeeded |           | 71.7s    | 11:01:18 11/10/16 | 11:02:29 11/10/16 |
|     2.1 configure_node          | succeeded | wordpress | 71.7s    | 11:01:18 11/10/16 | 11:02:29 11/10/16 |
|   3 nginx and php install       | executing |           |          | 11:02:30 11/10/16 |                   |
|     3.1 configure_node          | executing | wordpress |          | 11:02:30 11/10/16 |                   |
|   4 wordpress install and setup |           |           |          |                   |                   |
|     4.1 configure_node          |           | wordpress |          |                   |                   |
+---------------------------------+-----------+-----------+----------+-------------------+-------------------+
8 rows in set
~/dtk/service/wordpress-wordpress_single_node$ dtk service task-status
+---------------------------------+-----------+-----------+----------+-------------------+-------------------+
| TASK TYPE                       | STATUS    | NODE      | DURATION | STARTED AT        | ENDED AT          |
+---------------------------------+-----------+-----------+----------+-------------------+-------------------+
| assembly_converge               | succeeded |           | 203.3s   | 10:59:48 11/10/16 | 11:03:12 11/10/16 |
|   1 create_node                 | succeeded | wordpress | 89.3s    | 10:59:48 11/10/16 | 11:01:18 11/10/16 |
|   2 mysql install               | succeeded |           | 71.7s    | 11:01:18 11/10/16 | 11:02:29 11/10/16 |
|     2.1 configure_node          | succeeded | wordpress | 71.7s    | 11:01:18 11/10/16 | 11:02:29 11/10/16 |
|   3 nginx and php install       | succeeded |           | 29.3s    | 11:02:30 11/10/16 | 11:02:59 11/10/16 |
|     3.1 configure_node          | succeeded | wordpress | 29.3s    | 11:02:30 11/10/16 | 11:02:59 11/10/16 |
|   4 wordpress install and setup | succeeded |           | 12.5s    | 11:02:59 11/10/16 | 11:03:12 11/10/16 |
|     4.1 configure_node          | succeeded | wordpress | 12.5s    | 11:02:59 11/10/16 | 11:03:12 11/10/16 |
+---------------------------------+-----------+-----------+----------+-------------------+-------------------+
8 rows in set
{% endhighlight %}

To check what has been done, you can pick up ec2 public dns address of converged service instance and paste in browser:
{% highlight bash linenos %}
~/dtk/service/wordpress-wordpress_single_node$ dtk service list-nodes
+------------+-----------+-------------+----------+--------+-----------+------------------------------------------+
| ID         | NAME      | INSTANCE ID | SIZE     | OS     | OP STATUS | DNS NAME                                 |
+------------+-----------+-------------+----------+--------+-----------+------------------------------------------+
| 2147493071 | wordpress | i-bf56f6a9  | t2.small | ubuntu | running   | ec2-52-90-163-93.compute-1.amazonaws.com |
+------------+-----------+-------------+----------+--------+-----------+------------------------------------------+
1 row in set
{% endhighlight %}

Voila! You should be able to see wordpress starting page
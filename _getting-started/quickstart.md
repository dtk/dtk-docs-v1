---
title: Quickstart
order: 20
next_page:
  url: /components
---

# Dtk Quickstart

## Prerequisities
In order to start using Dtk via the quickstart method, there are following prerequisities:

  1. **Running EC2 Instance:** Make sure to have an AWS account handy, and a running EC2 instance that supports docker where you can deploy the Dtk software.  The EC2 instance doesnt have to be a large server, something like an m3.medium will be sufficient. 
  2. **Docker Installed:** Docker is required for the quickstart as we distribute the various Dtk pieces of software inside docker containers.  For more info on how to install Docker, please check: <a href="https://docs.docker.com/engine/installation" target="_blank">docker-installation</a> (Also make sure to configure Docker as a non-root user  <a href="https://docs.docker.com/engine/installation/linux/linux-postinstall/" target="_blank">Add user to usergroup</a>)
  3. **AWS VPC Instance:**  We will use a pre-existing VPC for this Quickstart demo.  If you do not have one consult the AWS docs to learn more about creating one: <a href="http://docs.aws.amazon.com/AmazonVPC/latest/GettingStartedGuide/getting-started-create-vpc.html" target="_blank">getting-started-create-vpc</a>.(Note: Please make sure that the following ports are enabled in the Security Group of the AWS instance: 2222, 6163, 80)
  4. **AWS IAM Credentials:** The Dtk will use IAM credentials to carry out actions such as EC2 machine deployment.  Make sure the IAM user you use has access to the VPC from step 3 above.



## Installation

### Installing the Dtk Server

Login to your AWS instance and create a directory which will serve as mounted host volume for your containers
{% highlight bash linenos %}
~$ mkdir dtk-server
~$ cd dtk-server
~/dtk-server$
{% endhighlight %}

Next, create configuration file called `dtk.config` inside directory from above. Add following content in `dtk.config` file:
{% highlight bash linenos %}
USERNAME=<USERNAME>
PASSWORD=<PASSWORD>
PUBLIC_ADDRESS=<PUBLIC_ADDRESS>
{% endhighlight %}

  * **USERNAME/PASSWORD:** credentials which will be used to connect to your Dtk Server instance
  * **PUBLIC_ADDRESS:** the accessible address of your EC2 instance you are installing the Dtk Server(ie: ec2 public dns or IP)

Run the installation script:
{% highlight bash linenos %}
\curl -sSL https://getserver.dtk.io | bash -s <DTK_CONFIG_DIRECTORY>
{% endhighlight %}

In this example, that is:
{% highlight bash linenos %}
\curl -sSL https://getserver.dtk.io | bash -s /home/ubuntu/dtk-server
{% endhighlight %}

You should have have your server up and running.  Next we will install the Dtk Client that will be the primary way you interact with your new Dtk Server.

### Installing the Dtk Client

Now we will install the Dtk Client.  For the Quickstart you can install Dtk Client on the same machine as the Server.  Typically you will install on a remote machine or on your local dev machine.  The Dtk Client can run on any machine that supports Ruby and has IP connectivity to the Dtk Server defined at the **PUBLIC_ADDRESS** value in the `dtk.config` file.

Create a Client install script configuration file called `dtk.config`.  You can use the same one if installing on the Server machine, else copy the credentials and PUBLIC_ADDRESS you set in the Server config and write to a local `dtk.config` file:
{% highlight bash linenos %}
USERNAME=<USERNAME>
PASSWORD=<PASSWORD>
PUBLIC_ADDRESS=<PUBLIC_ADDRESS>
{% endhighlight %}

Run the Client install script.  If installing on the same machine as the Server use the same `dtk` directory path for the **DTK_CONFIG_DIRECTORY** value used in the Server installation:
{% highlight bash linenos %}
\curl -sSL https://getclient.dtk.io | bash -s <DTK_CONFIG_DIRECTORY>
{% endhighlight %}

In this example, assuming that `dtk.config` is located in same dtk-server directory that is:
{% highlight bash linenos %}
\curl -sSL https://getclient.dtk.io | bash -s /home/ubuntu/dtk-server/
This script will do the following:

* Install the dtk-client gem
* Genereate an SSH keypair for the user the script is run under (if one does not exist)
* Genereate dtk-client configuration files

Installing dtk-client gem
1 gem installed
{% endhighlight %}

The Dtk Client will generate on first run its own ~/dtk directory which will be generated on your users home directory and it contains the generated client configuration. You are now able to login using Dtk client for the first time and connect to your Dtk Server instance.  Run `dtk` to setup initial Config and verify connectivity(answer 'no' for Dtk Catalog credentials for now, we will set those later):

{% highlight bash linenos %}
~$ dtk
[INFO] Processing ...
Do you have Dtk Catalog credentials? (yes|no)
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
    account - Subcommands for interacting with current Account
    help    - Shows a list of commands or help for one command
    module  - Subcommands for interacting with DTK modules
    service - Subcommands for creating and interacting with DTK service instances
{% endhighlight %}

You now have the Server and Client up and running and are ready to start using your new Dtk setup

## Initial Target setup
Now that you have Dtk up and running, first thing you need to do is to create an initial Target to deploy your Services into.  For this Quickstart have your VPC and IAM credentials handy from the Prerequisities section at the top of the page.

The Dtk Client will use local storage to manage working copies of Dtk Modules for you as you do your work.  Most of the time you will want to organize your Modules in some directory structure that makes most sense to you.  For this Quickstart we will use a `modules` directory and put Target related Modules under the `modules/target` sub-directory.

{% highlight bash linenos %}
~$ mkdir modules
~$ cd modules
~/modules$ mkdir target
~/modules$ cd target
{% endhighlight %}

Lets install the Quickstart Module to create your first Target:

{% highlight bash linenos %}
~/modules/target$ dtk module install aws/network
[INFO] Auto-importing dependencies
Importing module 'aws:ec2' ... [INFO] Done.
Importing module 'aws:identity_aws' ... [INFO] Done.
Importing module 'aws:image_aws' ... [INFO] Done.
Importing module 'aws:network_aws' ... [INFO] Done.
[INFO] Successfully imported 'aws:network' version 1.0.3

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
~/modules/target$ dtk module stage --target target
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
~/modules/wordpress$ dtk module install dtk-examples/wordpress
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
[INFO] Successfully imported 'dtk-examples:wordpress' version 1.4.0
{% endhighlight %}

Now that we have module installed, next thing is to stage assembly template from that module. We can do that using following command:
{% highlight bash linenos %}
~/modules/wordpress$ dtk module stage wordpress_single_node 
[INFO] Service instance 'wordpress-wordpress_single_node' has been created. In order to work with service instance, please navigate to: /home/docker-client/dtk/service/wordpress-wordpress_single_node
{% endhighlight %}

Next, we need to position to service instance directory, set required attributes and converge service instance:
{% highlight bash linenos %}
~/modules/wordpress$ cd ~/dtk/service/wordpress-wordpress_single_node
~/dtk/service/wordpress-wordpress_single_node$ dtk service converge
---
task_id: 2147493187
~/dtk/service/wordpress-wordpress_single_node$ dtk service task-status
+------------------------+-----------+-----------+----------+-------------------+----------+
| TASK TYPE              | STATUS    | NODE      | DURATION | STARTED AT        | ENDED AT |
+------------------------+-----------+-----------+----------+-------------------+----------+
| assembly_converge      | executing |           |          | 14:54:37 28/02/17 |          |
|   1 create_node        | executing | wordpress |          | 14:54:37 28/02/17 |          |
|   2 wordpress setup    |           |           |          |                   |          |
|     2.1 configure_node |           | wordpress |          |                   |          |
|   3 database setup     |           |           |          |                   |          |
|     3.1 configure_node |           | wordpress |          |                   |          |
|   4 web server setup   |           |           |          |                   |          |
|     4.1 configure_node |           | wordpress |          |                   |          |
+------------------------+-----------+-----------+----------+-------------------+----------+
8 rows in set
~/dtk/service/wordpress-wordpress_single_node$ dtk service task-status
+------------------------+-----------+-----------+----------+-------------------+-------------------+
| TASK TYPE              | STATUS    | NODE      | DURATION | STARTED AT        | ENDED AT          |
+------------------------+-----------+-----------+----------+-------------------+-------------------+
| assembly_converge      | executing |           |          | 14:54:37 28/02/17 |                   |
|   1 create_node        | succeeded | wordpress | 79.4s    | 14:54:37 28/02/17 | 14:55:56 28/02/17 |
|   2 wordpress setup    | executing |           |          | 14:55:56 28/02/17 |                   |
|     2.1 configure_node | executing | wordpress |          | 14:55:56 28/02/17 |                   |
|   3 database setup     |           |           |          |                   |                   |
|     3.1 configure_node |           | wordpress |          |                   |                   |
|   4 web server setup   |           |           |          |                   |                   |
|     4.1 configure_node |           | wordpress |          |                   |                   |
+------------------------+-----------+-----------+----------+-------------------+-------------------+
8 rows in set
~/dtk/service/wordpress-wordpress_single_node$ dtk service task-status
+------------------------+-----------+-----------+----------+-------------------+-------------------+
| TASK TYPE              | STATUS    | NODE      | DURATION | STARTED AT        | ENDED AT          |
+------------------------+-----------+-----------+----------+-------------------+-------------------+
| assembly_converge      | succeeded |           | 244.5s   | 14:54:37 28/02/17 | 14:58:41 28/02/17 |
|   1 create_node        | succeeded | wordpress | 79.4s    | 14:54:37 28/02/17 | 14:55:56 28/02/17 |
|   2 wordpress setup    | succeeded |           | 97.2s    | 14:55:56 28/02/17 | 14:57:34 28/02/17 |
|     2.1 configure_node | succeeded | wordpress | 97.2s    | 14:55:56 28/02/17 | 14:57:34 28/02/17 |
|   3 database setup     | succeeded |           | 49.4s    | 14:57:34 28/02/17 | 14:58:23 28/02/17 |
|     3.1 configure_node | succeeded | wordpress | 49.4s    | 14:57:34 28/02/17 | 14:58:23 28/02/17 |
|   4 web server setup   | succeeded |           | 17.9s    | 14:58:23 28/02/17 | 14:58:41 28/02/17 |
|     4.1 configure_node | succeeded | wordpress | 17.9s    | 14:58:23 28/02/17 | 14:58:41 28/02/17 |
+------------------------+-----------+-----------+----------+-------------------+-------------------+
8 rows in set
{% endhighlight %}

To check what has been done, you can pick up ec2 public dns address of converged service instance and paste in browser:
{% highlight bash linenos %}
~/dtk/service/wordpress-wordpress_single_node$ dtk service list-nodes
+------------+-----------+---------------------+----------+--------+-----------+-------------------------------------------+
| ID         | NAME      | INSTANCE ID         | SIZE     | OS     | OP STATUS | DNS NAME                                  |
+------------+-----------+---------------------+----------+--------+-----------+-------------------------------------------+
| 2147487632 | wordpress | i-03fb46423d565fb4f | t2.small | ubuntu | running   | ec2-54-172-18-241.compute-1.amazonaws.com |
+------------+-----------+---------------------+----------+--------+-----------+-------------------------------------------+
1 row in set
{% endhighlight %}

Voila! You should be able to see wordpress starting page

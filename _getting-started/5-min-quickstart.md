---
title: 5 Minute Quickstart
order: 20
---

# Dtk 5 Minute Quickstart

## Prerequisities
In order to start using DTK, there are following prerequisities:

### AWS Account
User needs to create AWS account because most provisioning done via DTK will be on AWS instances. For more info, please check: https://aws.amazon.com/account

### Docker
User needs to install Docker because DTK Server is running inside docker container. For more info, please check: https://docs.docker.com/engine/installation

## Quick install
TODO /Content for DTK server and DTK client installation/

## Target setup
Now that you have DTK up and running, first thing you need to do is to create target. You can think of a target as initial VPC (Virtual Private Cloud) infrastructure that needs to be set on AWS so user would be able to use DTK to provision new instances on AWS. In order to create target, you need to have VPC already created on AWS. For more information on how to create VPC, check: http://docs.aws.amazon.com/AmazonVPC/latest/GettingStartedGuide/getting-started-create-vpc.html

Next thing to do is to install target related module:

{% highlight bash linenos %}
dtk module install -d /tmp/network_aws -v 1.0.0 aws/network
[INFO] Auto-importing dependencies
Using module 'aws:ec2'
Using module 'aws:image_aws'
Importing module 'aws:network_aws' ... [INFO] Done.
[INFO] Successfully imported 'aws:network' version 1.0.0

dtk module list-assemblies -d /tmp/network_aws
+------------+---------------+-------+-------------+
| ID         | ASSEMBLY NAME | NODES | DESCRIPTION |
+------------+---------------+-------+-------------+
| 2147485655 | target        | 0     |             |
+------------+---------------+-------+-------------+
{% endhighlight %}

Now that we have target related module installed, it is time to create new target:

First, we will stage new target
{% highlight bash linenos %}
dtk service stage --target -d /tmp/network_aws
[INFO] Service instance 'network-target' has been created. In order to work with service instance, please navigate to: /home/docker-client/dtk/network-target
{% endhighlight %}

After staging target, we need to set required attributes (aws related attributes) for staged target
{% highlight bash linenos %}
dtk service set-required-attributes -d dtk/network-target

Please fill in missing data.
Please enter network_aws::iam_user[default]/aws_access_key_id [STRING]:
: <AWS_ACCESS_KEY_ID>
Please enter network_aws::iam_user[default]/aws_secret_access_key [STRING]:
: <AWS_SECRET_ACCESS_KEY>
Please enter network_aws::vpc[vpc1]/default_keypair [STRING]:
: <DEFAULT_KEYPAIR>
--------------------------------- DATA ---------------------------------
network_aws::iam_user[default]/aws_access_key_id : <AWS_ACCESS_KEY_ID>
network_aws::iam_user[default]/aws_secret_access_key : <AWS_SECRET_ACCESS_KEY>
network_aws::vpc[vpc1]/default_keypair : <DEFAULT_KEYPAIR>
------------------------------------------------------------------------
Is provided information ok? (yes|no) yes
{% endhighlight %}

There are multiple scenarios when configuring target (this will be discussed in DTK documentation) but the most straghtforward one is to setup target in same vpc where your DTK Server instance resides. To do that, no additional configuration is needed. Therefore, next step is to converge target

{% highlight bash linenos %}
dtk service converge -d dtk/network-target
{% endhighlight %}

If converge passed successfully, that means that we are ready to provision assembly templates in newly created target that actually points to SAME vpc, subnet and security group where your DTK Server instance resides.

## Module installation and service provisioning
In order to show how provisioning works via DTK, we will use basic example of assembly template that deploys apache web server.

In order to do that, we need to install dtk-example/apache module:
{% highlight bash linenos %}
docker-client@ip-172-30-0-247:/tmp$ mkdir apache
docker-client@ip-172-30-0-247:/tmp/apache$ dtk module install -v 0.0.1 dtk-examples/apache
[INFO] Auto-importing dependencies
Importing module 'puppetlabs:apache' ...
Importing module 'puppetlabs:concat' ... [INFO] Done.
Importing module 'puppetlabs:stdlib' ... [INFO] Done.
[INFO] Done.
Using module 'aws:ec2'
Importing module 'dtk-examples:simple_app' ... [INFO] Done.
[INFO] Successfully imported 'dtk-examples:apache' version 0.0.1
{% endhighlight %}

Now that we have module installed, next thing is to stage assembly template from that module. We can do that using following command:
{% highlight bash linenos %}
docker-client@ip-172-30-0-247:/tmp/apache$ dtk service stage
[INFO] Service instance 'apache-simple' has been created. In order to work with service instance, please navigate to: /home/docker-client/dtk/apache-simple
{% endhighlight %}

Next, we need to position to service instance directory and set required attributes:
{% highlight bash linenos %}
docker-client@ip-172-30-0-247:~/dtk/apache-simple$ dtk service set-required-attributes

Please fill in missing data.
Please enter test/image (Logical term describing the image) [STRING]:
: amazon_hvm
--------------------------------- DATA ---------------------------------
test/image (Logical term describing the image) : amazon_hvm
------------------------------------------------------------------------
Is provided information ok? (yes|no) yes
{% endhighlight %}

Finally, we will converge service instance and observe results:
{% highlight bash linenos %}
docker-client@ip-172-30-0-247:~/dtk/apache-simple$ dtk service converge
---
task_id: 2147487569
docker-client@ip-172-30-0-247:~/dtk/apache-simple$ dtk service task-status
+------------------------+-----------+------+----------+-------------------+----------+
| TASK TYPE              | STATUS    | NODE | DURATION | STARTED AT        | ENDED AT |
+------------------------+-----------+------+----------+-------------------+----------+
| assembly_converge      | executing |      |          | 15:00:38 21/09/16 |          |
|   1 create_node        | executing | test |          | 15:00:38 21/09/16 |          |
|   2 configure_nodes    |           |      |          |                   |          |
|     2.1 configure_node |           | test |          |                   |          |
+------------------------+-----------+------+----------+-------------------+----------+
4 rows in set
...
docker-client@ip-172-30-0-247:~/dtk/apache-simple$ dtk service task-status
+------------------------+-----------+------+----------+-------------------+-------------------+
| TASK TYPE              | STATUS    | NODE | DURATION | STARTED AT        | ENDED AT          |
+------------------------+-----------+------+----------+-------------------+-------------------+
| assembly_converge      | succeeded |      | 224.2s   | 15:00:38 21/09/16 | 15:04:22 21/09/16 |
|   1 create_node        | succeeded | test | 181.1s   | 15:00:38 21/09/16 | 15:03:39 21/09/16 |
|   2 configure_nodes    | succeeded |      | 42.9s    | 15:03:40 21/09/16 | 15:04:22 21/09/16 |
|     2.1 configure_node | succeeded | test | 42.9s    | 15:03:40 21/09/16 | 15:04:22 21/09/16 |
+------------------------+-----------+------+----------+-------------------+-------------------+
4 rows in set
{% endhighlight %}

To check what has been done, you can pick up ec2 public dns address of converged service instance and paste in browser:
{% highlight bash linenos %}
docker-client@ip-172-30-0-247:~/dtk/apache-simple$ dtk service list-nodes
+------------+------+-------------+----------+--------------+-----------+--------------------------------------------+
| ID         | NAME | INSTANCE ID | SIZE     | OS           | OP STATUS | DNS NAME                                   |
+------------+------+-------------+----------+--------------+-----------+--------------------------------------------+
| 2147490384 | test | i-7e5c5769  | t2.small | amazon-linux | running   | ec2-54-227-187-157.compute-1.amazonaws.com |
+------------+------+-------------+----------+--------------+-----------+--------------------------------------------+
1 row in set
{% endhighlight %}

Voila! You should be able to see rendered page with message: "Provisioned via DTK"

---
title: 5 Minute Quickstart
order: 20
---

# Dtk 5 Minute Quickstart

## Prereqs

### Docker


### AWS Account

## Quick install

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

{% highlight bash linenos %}
dtk service stage --target -d /tmp/network_aws
[INFO] Service instance 'network-target' has been created. In order to work with service instance, please navigate to: /home/docker-client/dtk/network-target
{% endhighlight %}

{% highlight bash linenos %}
dtk service set-required-attributes -d dtk/network-target

Please fill in missing data.
Please enter network_aws::iam_user[default]/aws_access_key_id [STRING]:
: <AWS_ACCESS_KEY_ID>
Please enter network_aws::iam_user[default]/aws_secret_access_key [STRING]:
: <AWS_SECRET_ACCESS_KEY>
Please enter network_aws::vpc[vpc1]/default_keypair [STRING]:
: <DEFAULT_KEYPAIR>
Please enter network_aws::vpc[vpc1]/vpc_id (AWS VPC id) [STRING]:
: <VPC_ID>
Please enter network_aws::vpc_subnet[vpc1-public]/subnet_length (Length of subnet that will be created) [STRING]:
: <SUBNET_LENGTH>
--------------------------------- DATA ---------------------------------
network_aws::iam_user[default]/aws_access_key_id : <AWS_ACCESS_KEY_ID>
network_aws::iam_user[default]/aws_secret_access_key : <AWS_SECRET_ACCESS_KEY>
network_aws::vpc[vpc1]/default_keypair : <DEFAULT_KEYPAIR>
network_aws::vpc[vpc1]/vpc_id (AWS VPC id) : <VPC_ID>
network_aws::vpc_subnet[vpc1-public]/subnet_length (Length of subnet that will be created) : <SUBNET_LENGTH>
------------------------------------------------------------------------
Is provided information ok? (yes|no) yes
{% endhighlight %}

{% highlight bash linenos %}
dtk service converge -d dtk/network-target
{% endhighlight %}

If converge passed successfully, that means that we are ready to provision assembly templates in newly created target that actually points to specific subnet and vpc on AWS.

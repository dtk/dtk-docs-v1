---
title: Aws
order: 1
---
# Targets for Amazon Webservices

## Modules

aws/network module is used for spinning up target. Since this module is pre-requisite for spinning up any kind of service instance, first thing we need to do is to install module:

{% highlight bash linenos %}
~/modules/target$ dtk module install -v 1.0.0 aws/network
[INFO] Auto-importing dependencies
Importing module 'aws:ec2' ... [INFO] Done.
Importing module 'aws:identity_aws' ... [INFO] Done.
Importing module 'aws:image_aws' ... [INFO] Done.
Importing module 'aws:network_aws' ... [INFO] Done.
[INFO] Successfully imported 'aws:network' version 1.0.0
{% endhighlight %}

This module contains two assembly templates: target and target_iam. If you want to create target using AWS credentials, then you can use target assembly template. If your DTK server is running on EC2 machine that has IAM role associated and that IAM role has access to VPC and EC2, you can use target_iam assembly template.

You can see list of available assemblies for aws/network module using following command:

{% highlight bash linenos %}
~/modules/target$ dtk module list-assemblies
+------------+---------------+-------+-------------+
| ID         | ASSEMBLY NAME | NODES | DESCRIPTION |
+------------+---------------+-------+-------------+
| 2147484478 | target_iam    | 0     |             |
| 2147484481 | target        | 0     |             |
+------------+---------------+-------+-------------+
2 rows in set
{% endhighlight %}

When creating target, we are actually configuring VPC resources that will be used for all service instances that will be provisioned via DTK using this target. Following VPC resources can be configured via target:

### Subnet: 
This component gives ability to either create new or specify existing subnet id (if we have subnet already created on VPC)
If new subnet is created, it is checked whether or not CIDR block is specified, if yes that one will be used if not new one will be generated (for example: if VPC CIDR block is 10.0.0.0/16 and subnet length specified is /24 then generated subnet will be 10.0.0.0/24) 
If there is already existing subnet in VPC and we decide to create new one, that is also supported - CIDR block for new one will automatically be generated)

### Routing table:
Without any users input, it is checked whether or not routing table exists for specified subnet and if it is associated with this subnet. If routing table does not exist, we create it and associate it with subnet

### Internet Gateway (IGW): 
User can specify gateway types on input: internet or none. First, we check if IGW exists in this VPC. If yes and gateway type is internet, we add route to IGW in routing table from above (otherwise, we create new IGW and add it to routing table). If yes and gateway type is none, we check if IGW is added to routing table from above and if yes, we remove it from routing table

### Security group: 
Based on Group ID and Group Name values and Dynamic/Constant rules specified by user on input we can execute following actions for security groups:
  * Group ID specified - We add rules to security group identified by Group ID
  * Group Name specified - We add rules to security group identified by Group Name
  * Group ID and Group Name NOT specified - We create new security group and add rules

Note: Rules are specified as arrays of hashes on input for both Dynamic and Constant attributes. Rule hash consists of following attributes: protocol, port_range and source. This is an example of rule:
[{protocol=>tcp, port_range=>22-22, source=>0.0.0.0/0}, {protocol=>tcp, port_range=>0-65535, source=>SAME}]
This is pretty self-explanatory except of the SAME value for source which indicates that source will be Group ID of security group to which we add this rule. Reading the rule from above, this essentially means that all inbound traffic from instances assigned to this same security group will be allowed.
There is also algorithm for dealing with Dynamic and Constant attributes:
  * If Constant rules are specified but Dynamic are NOT, Constant rules will be taken into account and added to security group
  * If both Constant and Dynamic rules are specified, remove all existing rules from security group, merge these two lists of rules and apply them to security group
  * If both Constant and Dynamic rules are NOT specified, leave it as it is

First, we will take a look at using target assembly template. In order to create target, you need to stage new target:

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

There are couple of possible scenarios we support when creating target in your VPC:

Note: VPC needs to exist on AWS in any of the provided scenarios

## Scenario 1: Create target when VPC, subnet and security group are not specified

This is scenario where no further configuration is needed. To create new target use converge command:
{% highlight bash linenos %}
~/dtk/service/network-target$ dtk service converge
{% endhighlight %}
In this scenario, target will pick VPC data from the actual host where DTK Server is running so no additional configuration is needed. To check data VPC related data retrieved after converge of target is completed, we can use list-attributes command:

{% highlight bash linenos %}
~/dtk/service/network-target$ dtk service list-attributes
+------------+------------------------------------------------------------------+---------------------------------------------------+---------+
| ID         | PATH                                                             | VALUE                                             | TYPE    |
+------------+------------------------------------------------------------------+---------------------------------------------------+---------+
| 2147489472 | network_aws::security_group[vpc1-default]/constant_rules         | [{protocol=>tcp, port_range=>22-22, source=>0 ... | array   |
| 2147489471 | network_aws::security_group[vpc1-default]/description            | security_group                                    | string  |
| 2147489473 | network_aws::security_group[vpc1-default]/dynamic_rules          | []                                                | array   |
| 2147489469 | network_aws::security_group[vpc1-default]/group_id               | sg-7cf2ee1b                                       | string  |
| 2147489470 | network_aws::security_group[vpc1-default]/group_name             | default                                           | string  |
| 2147489475 | network_aws::security_group[vpc1-default]/region                 | us-east-1                                         | string  |
| 2147489477 | network_aws::security_group[vpc1-default]/role_name              | na                                                | string  |
| 2147489474 | network_aws::security_group[vpc1-default]/vpc_id                 |                                                   | string  |
| 2147489453 | network_aws::setup/docker_worker                                 | true                                              | boolean |
| 2147489445 | network_aws::vpc[vpc1]/cidr_block                                |                                                   | string  |
| 2147489448 | network_aws::vpc[vpc1]/default_keypair                           | testing_use1                                      | string  |
| 2147489444 | network_aws::vpc[vpc1]/region                                    | us-east-1                                         | string  |
| 2147489443 | network_aws::vpc[vpc1]/vpc_id                                    |                                                   | string  |
| 2147489459 | network_aws::vpc_subnet[vpc1-default]/availability_zone          | us-east-1c                                        | string  |
| 2147489462 | network_aws::vpc_subnet[vpc1-default]/enable_public_ip_in_subnet | true                                              | boolean |
| 2147489455 | network_aws::vpc_subnet[vpc1-default]/gateway                    | internet                                          | string  |
| 2147489467 | network_aws::vpc_subnet[vpc1-default]/role_name                  | na                                                | string  |
| 2147489460 | network_aws::vpc_subnet[vpc1-default]/subnet_cidr_block          | 172.30.1.0/24                                     | string  |
| 2147489456 | network_aws::vpc_subnet[vpc1-default]/subnet_id                  | subnet-af44b8d8                                   | string  |
| 2147489461 | network_aws::vpc_subnet[vpc1-default]/subnet_length              | 24                                                | string  |
| 2147489457 | network_aws::vpc_subnet[vpc1-default]/vpc_id                     | vpc-5a63bc3f                                      | string  |
+------------+------------------------------------------------------------------+---------------------------------------------------+---------+
21 rows in set
{% endhighlight %}

## Scenario 2: Create target when VPC, subnet length and security group name are specified

This is scenario where user wants to customize target that needs to be created more. User will provide subnet length for subnet cidr block that will be generated automatically and assigned to newly created subnet and security group name for security group that needs to be created. Setup and converge could be done in following way:
{% highlight bash linenos %}
~/dtk/service/network-target$ dtk service list-attributes
+------------+------------------------------------------------------------------+---------------------------------------------------+---------+
| ID         | PATH                                                             | VALUE                                             | TYPE    |
+------------+------------------------------------------------------------------+---------------------------------------------------+---------+
| 2147489877 | network_aws::security_group[vpc1-default]/constant_rules         | [{protocol=>tcp, port_range=>22-22, source=>0 ... | array   |
| 2147489876 | network_aws::security_group[vpc1-default]/description            | security_group                                    | string  |
| 2147489878 | network_aws::security_group[vpc1-default]/dynamic_rules          | []                                                | array   |
| 2147489874 | network_aws::security_group[vpc1-default]/group_id               |                                                   | string  |
| 2147489875 | network_aws::security_group[vpc1-default]/group_name             | default                                           | string  |
| 2147489880 | network_aws::security_group[vpc1-default]/region                 | us-east-1                                         | string  |
| 2147489882 | network_aws::security_group[vpc1-default]/role_name              | na                                                | string  |
| 2147489879 | network_aws::security_group[vpc1-default]/vpc_id                 |                                                   | string  |
| 2147489858 | network_aws::setup/docker_worker                                 | true                                              | boolean |
| 2147489850 | network_aws::vpc[vpc1]/cidr_block                                |                                                   | string  |
| 2147489853 | network_aws::vpc[vpc1]/default_keypair                           | testing_use1                                      | string  |
| 2147489849 | network_aws::vpc[vpc1]/region                                    | us-east-1                                         | string  |
| 2147489848 | network_aws::vpc[vpc1]/vpc_id                                    |                                                   | string  |
| 2147489864 | network_aws::vpc_subnet[vpc1-default]/availability_zone          | us-east-1c                                        | string  |
| 2147489867 | network_aws::vpc_subnet[vpc1-default]/enable_public_ip_in_subnet | true                                              | boolean |
| 2147489860 | network_aws::vpc_subnet[vpc1-default]/gateway                    | internet                                          | string  |
| 2147489872 | network_aws::vpc_subnet[vpc1-default]/role_name                  | na                                                | string  |
| 2147489865 | network_aws::vpc_subnet[vpc1-default]/subnet_cidr_block          |                                                   | string  |
| 2147489861 | network_aws::vpc_subnet[vpc1-default]/subnet_id                  |                                                   | string  |
| 2147489866 | network_aws::vpc_subnet[vpc1-default]/subnet_length              |                                                   | string  |
| 2147489862 | network_aws::vpc_subnet[vpc1-default]/vpc_id                     |                                                   | string  |
+------------+------------------------------------------------------------------+---------------------------------------------------+---------+
21 rows in set
~/dtk/service/network-target$ dtk service set-attribute network_aws::vpc[vpc1]/vpc_id vpc-5a63bc3f
~/dtk/service/network-target$ dtk service set-attribute network_aws::vpc_subnet[vpc1-default]/subnet_length 28
~/dtk/service/network-target$ dtk service converge
{% endhighlight %}

When converge is completed, we can examine VPC resources created using list-attributes command:
{% highlight bash linenos %}
~/dtk/service/network-target$ dtk service list-attributes
+------------+------------------------------------------------------------------+---------------------------------------------------+---------+
| ID         | PATH                                                             | VALUE                                             | TYPE    |
+------------+------------------------------------------------------------------+---------------------------------------------------+---------+
| 2147489877 | network_aws::security_group[vpc1-default]/constant_rules         | [{protocol=>tcp, port_range=>22-22, source=>0 ... | array   |
| 2147489876 | network_aws::security_group[vpc1-default]/description            | security_group                                    | string  |
| 2147489878 | network_aws::security_group[vpc1-default]/dynamic_rules          | []                                                | array   |
| 2147489874 | network_aws::security_group[vpc1-default]/group_id               | sg-2282f747                                       | string  |
| 2147489875 | network_aws::security_group[vpc1-default]/group_name             | default                                           | string  |
| 2147489880 | network_aws::security_group[vpc1-default]/region                 | us-east-1                                         | string  |
| 2147489882 | network_aws::security_group[vpc1-default]/role_name              | na                                                | string  |
| 2147489879 | network_aws::security_group[vpc1-default]/vpc_id                 | vpc-5a63bc3f                                      | string  |
| 2147489858 | network_aws::setup/docker_worker                                 | true                                              | boolean |
| 2147489850 | network_aws::vpc[vpc1]/cidr_block                                | 172.30.0.0/16                                     | string  |
| 2147489853 | network_aws::vpc[vpc1]/default_keypair                           | testing_use1                                      | string  |
| 2147489849 | network_aws::vpc[vpc1]/region                                    | us-east-1                                         | string  |
| 2147489848 | network_aws::vpc[vpc1]/vpc_id                                    | vpc-5a63bc3f                                      | string  |
| 2147489864 | network_aws::vpc_subnet[vpc1-default]/availability_zone          | us-east-1c                                        | string  |
| 2147489867 | network_aws::vpc_subnet[vpc1-default]/enable_public_ip_in_subnet | true                                              | boolean |
| 2147489860 | network_aws::vpc_subnet[vpc1-default]/gateway                    | internet                                          | string  |
| 2147489872 | network_aws::vpc_subnet[vpc1-default]/role_name                  | na                                                | string  |
| 2147489865 | network_aws::vpc_subnet[vpc1-default]/subnet_cidr_block          | 172.30.2.16/28                                    | string  |
| 2147489861 | network_aws::vpc_subnet[vpc1-default]/subnet_id                  | subnet-e5fc98ac                                   | string  |
| 2147489866 | network_aws::vpc_subnet[vpc1-default]/subnet_length              | 28                                                | string  |
| 2147489862 | network_aws::vpc_subnet[vpc1-default]/vpc_id                     | vpc-5a63bc3f                                      | string  |
+------------+------------------------------------------------------------------+---------------------------------------------------+---------+
21 rows in set
{% endhighlight %}
Take a look at following attributes:
- network_aws::vpc_subnet[vpc1-default]/subnet_cidr_block - generated subnet cidr block
- network_aws::vpc_subnet[vpc1-default]/subnet_id - id from newly created subnet
- network_aws::security_group[vpc1-default]/group_name - security group name specified
- network_aws::security_group[vpc1-default]/group_id - id from newly crated security group

## Scenario 3: Create target when VPC, existing subnet id and existing security group are specified
This is scenario where user wants to specify existing subnet id and existing security group that will be used for new target. Setup and converge could be done in following way:

{% highlight bash linenos %}
docker-client@ip-172-30-1-101:~/dtk/service/network-target-6$ dtk service list-attributes
+------------+------------------------------------------------------------------+---------------------------------------------------+---------+
| ID         | PATH                                                             | VALUE                                             | TYPE    |
+------------+------------------------------------------------------------------+---------------------------------------------------+---------+
| 2147489632 | network_aws::security_group[vpc1-default]/constant_rules         | [{protocol=>tcp, port_range=>22-22, source=>0 ... | array   |
| 2147489631 | network_aws::security_group[vpc1-default]/description            | security_group                                    | string  |
| 2147489633 | network_aws::security_group[vpc1-default]/dynamic_rules          | []                                                | array   |
| 2147489629 | network_aws::security_group[vpc1-default]/group_id               |                                                   | string  |
| 2147489630 | network_aws::security_group[vpc1-default]/group_name             | default                                           | string  |
| 2147489635 | network_aws::security_group[vpc1-default]/region                 | us-east-1                                         | string  |
| 2147489637 | network_aws::security_group[vpc1-default]/role_name              | na                                                | string  |
| 2147489634 | network_aws::security_group[vpc1-default]/vpc_id                 |                                                   | string  |
| 2147489613 | network_aws::setup/docker_worker                                 | true                                              | boolean |
| 2147489605 | network_aws::vpc[vpc1]/cidr_block                                |                                                   | string  |
| 2147489608 | network_aws::vpc[vpc1]/default_keypair                           | testing_use1                                      | string  |
| 2147489604 | network_aws::vpc[vpc1]/region                                    | us-east-1                                         | string  |
| 2147489603 | network_aws::vpc[vpc1]/vpc_id                                    |                                                   | string  |
| 2147489619 | network_aws::vpc_subnet[vpc1-default]/availability_zone          | us-east-1c                                        | string  |
| 2147489622 | network_aws::vpc_subnet[vpc1-default]/enable_public_ip_in_subnet | true                                              | boolean |
| 2147489615 | network_aws::vpc_subnet[vpc1-default]/gateway                    | internet                                          | string  |
| 2147489627 | network_aws::vpc_subnet[vpc1-default]/role_name                  | na                                                | string  |
| 2147489620 | network_aws::vpc_subnet[vpc1-default]/subnet_cidr_block          |                                                   | string  |
| 2147489616 | network_aws::vpc_subnet[vpc1-default]/subnet_id                  |                                                   | string  |
| 2147489621 | network_aws::vpc_subnet[vpc1-default]/subnet_length              |                                                   | string  |
| 2147489617 | network_aws::vpc_subnet[vpc1-default]/vpc_id                     |                                                   | string  |
+------------+------------------------------------------------------------------+---------------------------------------------------+---------+
21 rows in set

~/dtk/service/network-target$ dtk service set-attribute network_aws::vpc[vpc1]/vpc_id vpc-5a63bc3f
~/dtk/service/network-target$ dtk service set-attribute network_aws::vpc_subnet[vpc1-default]/subnet_id subnet-b363f2fa
~/dtk/service/network-target$ dtk service set-attribute network_aws::security_group[vpc1-default]/group_id sg-c8ba76b5
~/dtk/service/network-target$ dtk service converge
{% endhighlight %}

When converge is completed, we can examine VPC resources created using list-attributes command:
{% highlight bash linenos %}
~/dtk/service/network-target$ dtk service list-attributes
+------------+------------------------------------------------------------------+---------------------------------------------------+---------+
| ID         | PATH                                                             | VALUE                                             | TYPE    |
+------------+------------------------------------------------------------------+---------------------------------------------------+---------+
| 2147489632 | network_aws::security_group[vpc1-default]/constant_rules         | [{protocol=>tcp, port_range=>22-22, source=>0 ... | array   |
| 2147489631 | network_aws::security_group[vpc1-default]/description            | security_group                                    | string  |
| 2147489633 | network_aws::security_group[vpc1-default]/dynamic_rules          | []                                                | array   |
| 2147489629 | network_aws::security_group[vpc1-default]/group_id               | sg-c8ba76b5                                       | string  |
| 2147489630 | network_aws::security_group[vpc1-default]/group_name             | default                                           | string  |
| 2147489635 | network_aws::security_group[vpc1-default]/region                 | us-east-1                                         | string  |
| 2147489637 | network_aws::security_group[vpc1-default]/role_name              | na                                                | string  |
| 2147489634 | network_aws::security_group[vpc1-default]/vpc_id                 | vpc-5a63bc3f                                      | string  |
| 2147489613 | network_aws::setup/docker_worker                                 | true                                              | boolean |
| 2147489605 | network_aws::vpc[vpc1]/cidr_block                                | 172.30.0.0/16                                     | string  |
| 2147489608 | network_aws::vpc[vpc1]/default_keypair                           | testing_use1                                      | string  |
| 2147489604 | network_aws::vpc[vpc1]/region                                    | us-east-1                                         | string  |
| 2147489603 | network_aws::vpc[vpc1]/vpc_id                                    | vpc-5a63bc3f                                      | string  |
| 2147489619 | network_aws::vpc_subnet[vpc1-default]/availability_zone          | us-east-1c                                        | string  |
| 2147489622 | network_aws::vpc_subnet[vpc1-default]/enable_public_ip_in_subnet | true                                              | boolean |
| 2147489615 | network_aws::vpc_subnet[vpc1-default]/gateway                    | internet                                          | string  |
| 2147489627 | network_aws::vpc_subnet[vpc1-default]/role_name                  | na                                                | string  |
| 2147489620 | network_aws::vpc_subnet[vpc1-default]/subnet_cidr_block          |                                                   | string  |
| 2147489616 | network_aws::vpc_subnet[vpc1-default]/subnet_id                  | subnet-b363f2fa                                   | string  |
| 2147489621 | network_aws::vpc_subnet[vpc1-default]/subnet_length              |                                                   | string  |
| 2147489617 | network_aws::vpc_subnet[vpc1-default]/vpc_id                     | vpc-5a63bc3f                                      | string  |
+------------+------------------------------------------------------------------+---------------------------------------------------+---------+
21 rows in set
{% endhighlight %}

Take a look at following attributes:
- network_aws::vpc_subnet[vpc1-default]/subnet_id - id from existing subnet
- network_aws::security_group[vpc1-default]/group_id - id from existing security group

Note: Enhancement needed for this scenario so we are able to: 
1. reset default group_name to security group name that corresponds to provided group_id
2. set subnet_cidr_block and subnet_length based on provided subnet_id
In nutshell, state of the attributes should be always the same (populated) after converge, regardless of scenario used

## Scenario 4: Create target when VPC specified but user specifies subnet cidr block for subnet that needs to be created

This scenario is very similar to scenario 2, but in this case, user specifies subnet cidr block of new subnet that will be created in VPC. Setup and converge could be done in following way:

{% highlight bash linenos %}
~/dtk/service/network-target$ dtk service set-attribute network_aws::vpc[vpc1]/vpc_id vpc-5a63bc3f
~/dtk/service/network-target$ dtk service set-attribute network_aws::vpc_subnet[vpc1-default]/subnet_cidr_block 172.30.15.0/24
~/dtk/service/network-target$ dtk service converge
{% endhighlight %}

When converge is completed, we can examine VPC resources created using list-attributes command:
{% highlight bash linenos %}
~/dtk/service/network-target$ dtk service list-attributes
+------------+------------------------------------------------------------------+---------------------------------------------------+---------+
| ID         | PATH                                                             | VALUE                                             | TYPE    |
+------------+------------------------------------------------------------------+---------------------------------------------------+---------+
| 2147490090 | network_aws::security_group[vpc1-default]/constant_rules         | [{protocol=>tcp, port_range=>22-22, source=>0 ... | array   |
| 2147490089 | network_aws::security_group[vpc1-default]/description            | security_group                                    | string  |
| 2147490091 | network_aws::security_group[vpc1-default]/dynamic_rules          | []                                                | array   |
| 2147490087 | network_aws::security_group[vpc1-default]/group_id               | sg-2282f747                                       | string  |
| 2147490088 | network_aws::security_group[vpc1-default]/group_name             | default                                           | string  |
| 2147490093 | network_aws::security_group[vpc1-default]/region                 | us-east-1                                         | string  |
| 2147490095 | network_aws::security_group[vpc1-default]/role_name              | na                                                | string  |
| 2147490092 | network_aws::security_group[vpc1-default]/vpc_id                 | vpc-5a63bc3f                                      | string  |
| 2147490071 | network_aws::setup/docker_worker                                 | true                                              | boolean |
| 2147490063 | network_aws::vpc[vpc1]/cidr_block                                | 172.30.0.0/16                                     | string  |
| 2147490066 | network_aws::vpc[vpc1]/default_keypair                           | testing_use1                                      | string  |
| 2147490062 | network_aws::vpc[vpc1]/region                                    | us-east-1                                         | string  |
| 2147490061 | network_aws::vpc[vpc1]/vpc_id                                    | vpc-5a63bc3f                                      | string  |
| 2147490077 | network_aws::vpc_subnet[vpc1-default]/availability_zone          | us-east-1c                                        | string  |
| 2147490080 | network_aws::vpc_subnet[vpc1-default]/enable_public_ip_in_subnet | true                                              | boolean |
| 2147490073 | network_aws::vpc_subnet[vpc1-default]/gateway                    | internet                                          | string  |
| 2147490085 | network_aws::vpc_subnet[vpc1-default]/role_name                  | na                                                | string  |
| 2147490078 | network_aws::vpc_subnet[vpc1-default]/subnet_cidr_block          | 172.30.15.0/24                                    | string  |
| 2147490074 | network_aws::vpc_subnet[vpc1-default]/subnet_id                  | subnet-42fb9f0b                                   | string  |
| 2147490079 | network_aws::vpc_subnet[vpc1-default]/subnet_length              |                                                   | string  |
| 2147490075 | network_aws::vpc_subnet[vpc1-default]/vpc_id                     | vpc-5a63bc3f                                      | string  |
+------------+------------------------------------------------------------------+---------------------------------------------------+---------+
21 rows in set
{% endhighlight %}
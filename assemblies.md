---
title: Dtk Assemblies
permalink: assemblies/index
previous_page:
  url: /components/providers
next_page:
  url: /assemblies/workflows
---

# Dtk Assemblies

A Dtk Assembly represents a set of interrelated Dtk Components that constitute an application, service or infrastructure to deploy or manage. This can be a simple single node application or be complex and distributed across nodes that exist or are spun up and/or are across one or multiple cloud services. 
A deployment can be organized as a single Assembly that deploys all layers of a stack together or instead could be designed using multiple Assemblies that are split and deployed in a layered way, such as
1. Base Assembly, which we refer to as a Target Assembly that provisions or discovers a networking context in a selected cloud service
2. Assembly that deploys a cluster on top of the Target
3. Assembly that deploys an application or jobs that runs on the cluster

To illustrate how the Dtk DSL encodes Assemblies, consider two Assemblies where we have
* Target Assembly that corresponds to an AWS VPC in a specified AWS region, and
* A wordpress Assembly that is deployed with respect to the VPC Target

The syntax below shows how an Assembly representing an AWS VPC target could be specified:
{% highlight bash linenos %}
    components:
    - network_aws::vpc[vpc1]:
        attributes:
          discovered: true
          region: us-east-1
          vpc_id: vpc-34abb450
    - network_aws::security_group[vpc1-default]:
        attributes:
          discovered: true
          group_id: sg-60d4be06
    - network_aws::vpc_subnet[vpc1-default]:
{% endhighlight %} 

This Assembly refers to an AWS VPC, security group, and subnet that can serve as one of potentially multiple contexts for spinning up the nodes in a service Assembly. If an Assembly is spun up with respect to this Target Assembly then any nodes spun up will be connected to the designated subnet and security group.

This example illustrates how the DTK can mix discovery and creation depending on what Components are used or what is their Attribute settings. In this example, the VPC and security group resources are discovered, while a VPC subnet will be created each time this Assembly is deployed. When an Assembly is deployed the create/converge Actions will appropriately perform discovery or resource creation. For discovered resources, an error can be raised if the resource does not exist or cannot be uniquely identified.

The Components in this example have syntax
{% raw %}
  MODULE-NAME::COMPONENT-NAME[INSTANCE-NAME]
{% endraw %}
This identifies which Module each Component is from and the Component’s name. INSTANCE-NAME is used if a Component can have multiple instantiations in the same context, It is used here because there can be multiple VPCs, subnets and security groups in the same region. The Components can be designed so that the logical names, such as ‘vpc1-default’ match the names of an actual resource or are decoupled. The advantage of decoupling logical names with actual resource names for resources that are created is then the Assembly can be instantiated multiple times without causing name clashes.

Below is an example Assembly for a wordpress application
{% highlight bash linenos %}
   nodes:
      wordpress:
        components:
        - nginx::server
        - wordpress::nginx_config
        - wordpress::app
        - mysql::server
{% endhighlight %} 

In contrast to the VPC Assembly where the Components referred to cloud resources, in this example the Components refer to things that can deployed on nodes, in this case a single node. If this assembly is deployed with respect to the above VPC Target then a single node will be spun up connecting to the subnet and security group tied to the VPC Target. On top this node, nginx, wordpress and mysql will be installed and configured to work together. This logic is captured by the create/converge actions defined in these Components.

The node name ‘wordpress’ is the logical name used to refer to and connect to a spun up AWS EC2 instance. If this Assembly is spun up multiple times, each time it would create a new instance that can be referred to by ‘wordpress’. Each of this deployments provides a context that the Dtk user can navigate to. How ‘wordpress’ is resolved to an actual cloud insatnces differs depending on context user is in. This provides a form of multi-tenancy.

In this example the Components have syntax
{% raw %}
  MODULE-NAME::COMPONENT-NAME
{% endraw %}
For these Components an Instance Name is not needed if there can only be one instantiation of the Component in a context, in this case the context being a node. We will sometimes refer to these type of Components as ‘Singletons’.

### Specifying a Node's image and size

In the example above there was no information given about the image associated with the wordpress node and its size. Attributes that capture these settings could be set in two ways:
* After an instance of the Assembly is staged the user can enter these values prior to executing a workflow to deploy it
* By using logical terms in the Service Assembly that get contingently and automatically bound depending on what Target the Assembly is staged respect to

For the latter case, the wordpress Assembly could look like:
{% highlight bash linenos %}
   nodes:
      wordpress:
        attributes:
          image: trusty_hvm
          size: small
        components:
        - nginx::server
        - wordpress::nginx_config
        - wordpress::app
        - mysql::server
{% endhighlight %} 

This shows a wordpress application that gets spun up on an Ubuntu Trusty hvm image that is of size ‘small’. If this Assembly was spun up with respect to the example VPC Target then ‘trusty_hvm’, would bind to a Trusty Hvm ami in the target’s region (us-east-1). It is also assumed that the VPC target includes a Component that is a dictionary that would map terms like ‘small’ to a concrete EC2 term such as ‘t2.small’. This mapping is customizable.

TODO: show some details about the Component that serves as a dictionary

TODO: flesh out these sub-sections

### Assembly Attributes

### Assembly Component Links and Auto Completion

### Assembly Node Groups


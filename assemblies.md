---
title: Dtk Assemblies
permalink: assemblies/index
---

# Dtk Assemblies

A Dtk Assembly represents a set of interrelated components that constitute an application, service or infrastructure to deploy or manage. This can be a simple single node application or be complex and distributed across nodes and/or multiple cloud services. An Assembly captures whether each component is deployed as a resource on a cloud service or installed on a single or set of nodes, which could be cloud instances, virtual machines, or physical machines.
### Single node Assembly
An example very simple Assembly is one that has an application on a single node:
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

This represents a wordpress application that gets spun up on an Ubuntu Trusty hvm image that is of size ‘small’. Exactly what these logical terms ‘trusty_hvm’ and ‘small’ get resolved to will be customized with respect to the Target Service Instance (i.e., deployment environment) that this Assembly is deployed with respect to. For example, the target environment can capture am AWS VPC in a set region. The term ‘trusty_hvm’ would bind to an ami in the target’s region that correspond to a Trusty Hvm OS. The size would also be customized depending on the target configuration, an example being‘t2.small’. 

The node name ‘wordpress’ is the logical name to refer to and connect to a spun up instance. The same Assembly can be instantiated multiple times, each time creating a new ‘Service Instance’ directory on the client machine. To manage a Service Instance, a user navigates to its directory and issues commands or edits the DSL file(s) under this directory. For Service Instances created from this example Assembly, references to the node name ‘wordpress’ get resolved to an actual cloud instance that would differ as user moved from Service Instance directory to directory

In the Assembly above, there is set of Components that are under the Node ‘wordpresss’. This means when a DTK action to actually create/deploy the assembly is executed these components get installed and configured on that node and the corresponding service daemons started.

Component references in this Assembly have form
* COMPONENT-NAME, and
* MODULE-NAME::COMPONENT-NAME

which identify the Component’s name and Module it is from. When just COMPONENT-NAME is given this means the module name and component name are the same.


### Assembly with Cloud Resource components
The wordpress Assembly needs to be spun up with respect to a deployed context. This is also represented by an Assembly that is assumed to be deployed. One such context for the wordpress Assembly is an AWS VPC given by:

{% highlight bash linenos %}
    components:
    - image_aws
    - network_aws::vpc[vpc1]:
        attributes:
          region: us-east-1
    - network_aws::vpc_subnet[vpc1-default]:
    - network_aws::security_group[vpc1-default]:
{% endhighlight %} 

In this case, rather than the having Components under a Node the Components are top level meaning they refer to resources on a cloud service. An assembly can also have Components some of which refer to cloud resources and others to Components on Nodes.

In the example above the Dtk Component ‘image_aws’ provides the bindings between logical names such as ‘trusty_hvm’ and ‘small’ and AWS EC2 amis (depending on region) and sizes such as ‘t2.size’. The vpc, vpc_subnet, and security group Components refer to the  AWS VPC respurces that provide the VPC context where the nodes are to be spun up. Dtk VPC Components can be defined to either discover or create VPC resources or do either depending on attribute settings.

In this example we have a component reference of the form:
* MODULE-NAME::COMPONENT-NAME[INSTANCE-NAME]
If a Component has same module name as component name than it would have form
* COMPONENT-NAME[INSTANCE-NAME}

The INSTANCE-NAME term is used with Components that can be instantiated multiple times in the same context (i.e., same cloud service context or same Node). In this case the three VPC resources all need instance names or what we sometimes call ‘Titles’, because there can be multiple vpcs, vpc subnets, and security groups in the same region. 

### Assembly Attributes

### Assembly Component Links and auto complete

### Assembly Node Groups

NOTE: from previous text

A typical deployment can have both Nodes and Node Groups, an example being a Spark cluster with a ‘Spark master’ Component running on a Node, and a set of its slaves that in the DTK DSL would be tied to a Node Group that can be scaled up or down


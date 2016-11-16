---
title: Dtk Components
permalink: components/index
---

# Dtk Components

Components are the basic Dtk building blocks that are composed to provide the capability to deploy, configure and manage applications and services. Some typical things Components can refer to are:
* Application code deployed in the different forms, such as code that is installed, code submitted to a cluster or cloud service, or deployed as containers
* Common infrastructure pieces, such as app servers, load balancers, proxies, database servers and clients, cluster components like Spark masters and slaves
* Resource in a cloud service, such as for AWS, vpc subnets, routing tables and security groups, RDS databases or Kinesis streams
* A reference dataset (e.g., in S3) that is being accessed or copied

A Dtk Component consists of bash scripts, code, or configuration logic (e.g. puppet class or definition) that perform the needed deployment, configuration, discovery, or management operations and DTK DSL description, which serves a similar role as an interface serves in Object Oriented languages.
The type of code or configuration language that can be used is extensible. Currently Bash, Puppet, and Ruby are supported. We refer to the logic that supports a particular language or configuration asset as a 'Language Provider'. Example Language Providers that can be added are ones for python, nodejs, Chef, AWS CloudFormation,

An example Component Dtk DSL description for a component ‘wordpress::app’ 
{% highlight bash linenos %}
    attributes:
      db_host:
        type: string
        required: true
      db_port:
        type: integer
        required: true
      db_name:
        type: string
        default: wordpress
      create_db:
        type: Boolean
        default: false
      version:
        type: string
    actions:
      create:
        puppet_definition: wordpress::instance
    dependencies:
      - mysql::server
    link_defs:
      mysql::server:
        attribute_mappings:
        - $node.host_address -> db_host
        - $port -> db_port
{% endhighlight %}

TODO: give a few paragraph explanation of this example

The sections 'dependencies' and 'link_defs' describe how 'wordpress::app' requires that the Component mysql::server be present (wince teh wordpress app needs a database) and captures how their attributes are coordinated so that wordpress::app has db_host and db_port set to point to the correct host address and port. The subsection 'Component Links' describes these relations in detail.
---
title: Dtk Assemblies
permalink: assemblies/index
---

# Dtk Assemblies

A Dtk Assembly represents  a set of interrelated components that constitute an application, service or infrastructure to deploy or manage. This can be a simple single node applications or be distributed across nodes or Internet services.

An Assembly captures whether each component is deployed on an Internet service or on a single or set of nodes, which could be cloud instances, virtual or physical machines.

A sample Assemble with components corresponding to cloud service resources is shown below 

This refers to an AWS vpc

A sample assembly with components on nodes is shown below that 


When a component is deployed on a node there are two variants:
* A component that goes on a single node
* A component that may be horizontally scaled where the same component configuration should go on a set of equivalent type nodes that can be scaled up and down. These are referred to as ‘Node Groups’

TODO: give some examples of assemblies.


A typical deployment can have both Nodes and Node Groups, an example being a Spark cluster with a ‘Spark master’ Component running on a Node, and a set of its slaves that in teh DTK DSL would be tied to a Node Group that can be scaled up or down


## Components, Nodes, and Node Groups

An example of components that are deployed on Internet services are ones that correspond to an AWS VPC

TODO: ...

### Nodes

# TODO: mention the attributes size and image

### Node Groups

Mention set cardinality as well as 

### Attributes


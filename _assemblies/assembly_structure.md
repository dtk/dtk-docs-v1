---
title: Assembly Structure
order: 1
---

# Assembly Structure

An assembly captures the set of components that constitute a deployment. For each component it captures where it is deployed, the high level alternatives being components that correspond to resources on an Internet service and components that get installed on nodes. When a component is deployed on a node there are two variants:
* A component that goes on a single node
* A component that may be horizontally scaled where the same component configuration should go on a set of equivalent type nodes that can be scaled up and down. These are referred to as ‘Node Groups’

OPEN QUESTION: should we just focus on DSL or also talk about Dtk service CLI commands that do equivalent things; inclination is just to focus on CLI

A typical deployment can have both Nodes and Node Groups, an example being a Spark cluster with a ‘Spark master’ Component running on a Node, and a set of its slaves that in teh DTK DSL would be tied to a Node Group that can be scaled up or down


## Components, Nodes, and Node Groups

An example of components that are deployed on Internet services are ones that correspond to an AWS VPC

TODO: ...

### Nodes

# TODO: mention the attributes size and image

### Node Groups

Mention set cardinality as well as 

### Attributes


### Component links
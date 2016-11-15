---
title: Assembly Structure
order: 1
---

# Assembly Structure

An assembly captures the set of components that constitut a deployment and where each component is deployed, the high level atrnatives being components that correspond to resources on an Internet service and components that get installed on nodes. When a component is deployed on a node there are two vraints supported:
* A component that goes on a single node
* A component that may be horizontally scaled where teh same component configuration shoudl go on a set of equivalent type nodes that can be scaled up and down. These are refrred to as 'Node Groups'

OPEN QUESTION: should we just focus on DSL or also talk about dtk service CLI commands that do equivalent things; inclination is just to focus on CLI

A typical deployment will have both nodes and node groups, an example being a Spark cluster with a 'Spark master' component running on a node, and a set of its slaves  running on a Node Group that can be scaled up or down

## Components, Nodes, and Node groups

An example of components that are deployed on Internet services are ones that correspond to an AWS VPC

TODO: ...

### Nodes

# TODO: mention the attributes size and image

### Node Groups

Mention set cardinality as well as 

### Attributes


### Component links
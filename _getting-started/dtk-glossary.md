---
title: DTK Glossary
order: 30
---

# DTK Glossary

**DTK Server** - Ruby based application which is running on an instance that handles requests from DTK Client. It manages users, installed components, does initial setup and deployment of service instances and performs node orchestration. 

**DTK Client** - Ruby based CLI interface for communication with the DTK Server. Its main purpose is to expose DTK server functionalities for operations on modules and setup/deployment of module assemblies.

**DTK Repo Manager** - Git based repository for publishing and installing modules and dependency modules. Users can install, publish, push and pull changes on modules. However, repoman also has fine grained access control which means not every module will be visible to every user.

**DTK Arbiter** - Ruby process which runs on every node that is provisioned and enables communication with DTK server using STOMP protocol. It is used to run actions that are initiated from DTK Server.

**Target** - You can think of a target as initial VPC (Virtual Private Cloud) infrastructure that needs to be set on AWS so user would be able to use DTK to provision new instances on AWS.

**Module** - Collection of logically similar assemblies (For example: module that contains Hadoop related assemblies). It also contains list of dependency modules whose components are used in those assemblies.

**Assembly** - Logical topology which defines nodes that will be created, components that will be provisioned on those nodes and provision ordering.

**Service instance** - Staged assembly which is ready to be provisioned. (You can think of service instance like instantiated object, while assembly is a class)

**Dependency modules** - Logical collection of components. Each dependency module contains dtk.model.yaml which represents blueprint/interface towards components that belong to this dependency module and represents logical relationships between them.

**Components** - Building blocks for assemblies. They are used to install and/or configure software packages, services, tests and required libraries. Main engine behind components can be puppet manifest, ruby script or any type of linux CLI command.

**Node** - Part of assembly and it contains one or more components. When converged, node is actually an AWS instance. There is also a special case of node called **assembly wide node** which runs on DTK Arbiter docker container on same instance where DTK Server docker container is started.

**Workflow** - Enables server instance orchestration. It defines set of components and actions that are going to be executed during converge process. It is especialy important in multi-node environments where orchestration and execution order has more importance. (for example: execute component A on node A, execute component B on node B, execute component C on node A.. etc)
---
title: Dtk Glossary
permalink: glossary/index
previous_page:
  url: /modules/publishing-sharing
---

# Dtk Glossary

**Dtk Server** - The brains behind the operation, its an Application that powers workflow/orchestration tasks, and allows users to coordinate and work together across diciplines

**Dtk Client** - Our CLI tool and programmatic interface for Dtk development and interacting with your Dtk managed Services.

**Dtk Network** - Site for the Dtk community and public Service Catalog to publish and share modules with other developers.

**Dtk Agent** - Process which runs on every Dtk managed node that enables communication with Dtk Server and carries out any Application or IT task the Dtk Server directs it to.

**Target** - You can think of a Target as managed context that all Services and Applications are deployed into.  An example would be an AWS Virtual Private Cloud (VPC), or a VSphere managed cluster.

**Components** - Building are your reusable building blocks for building up complex Services and Applications.  They are used to install and/or configure applications, packages, monitoring, etc.  Examples of Componets would be Mysql, Nginx, Hadoop, your custom application, AWS VPC, etc.

**Action** - Actions are the methods/functions available against an instance of a deployed Component.  Actions could be things like create/install, delete, upgrade, discover, etc.

**Assembly** - If Components are building blocks, Assemblies are topology definitions and sets of Components that are linked together to form comprehensive Services.  An example would be "three node application with a database, running in a VPC"

**Workflow** - A Worfklow defines a plan of execution tasks and Actions to be carried out against one or more Dtk managed Service Instances.  These tasks can be run against Components that are managed on physical/virtual nodes, or remotely againt external REST services (such as AWS resources).  By default the Dtk will auto-generate the default Workflows for you based on the Design/Toplogy of your Assembly.  You also have the ability to edit and create your how custom Workflows.

**Node** - Nodes contain components and can represent a physical, virtual, or container server 

**Module** - Modules handle the depedency management and packaging aspects of a Dtk solution.  They consist of reusable, logically grouped Components, Assemblies, and Targets.  An example of a module would be "aws_networking" which would contain Components for VPC, Subnet, Internet Gateway, etc.

**Service/Service Instance** - An Application or Service that has been staged and deployed to a Target.  You can think of a Service Instance like an instantiated object, while an Assembly is a class definition

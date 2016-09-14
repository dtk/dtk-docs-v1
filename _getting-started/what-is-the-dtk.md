---
title: What is the Dtk?
order: 1
---

The Devops Toolkit (DTK) provides a framework to enable configuration, deployment and orchestration of distributed or multi-tenant applications and services. Users will have the ability build/share re-usable Service Catalogs, as well as to spin up multiple development and testing environments. The DTK provides seamless and deep integration on top of state-based configuration management systems, such as Puppet, as well as Bash and other scripting mechanisms for node-level configuration. Following diagram gives better picture on how typical DTK workflow looks like:

![DTK Diagram]({{site.assetsBaseDir}}/img/diagrams/dtk_diagram_1.png "DTK diagram")

Since DTK is a deployment/orchestration tool for creating your own environments, the logical question is what environment consists of and how do you create one? Of course, environments should not be empty so the basic building blocks that we will be using are **components**. Components don't exist all by themselves and they are part of larger block which is called **component module**. One component module has one or many components.
The environment that we want to deploy is called **service**. Now, it would be very tedious process if we always started with empty service and had to add components and relationships between them. That's why we have **assembly templates** which represent a blueprint for some specific deployment scenario. Assembly templates also don't exist just on their own and they are part of bigger build blocks called **service modules**.
Example of service module would be "Web application". This module contain various different deployment scenarios (assembly templates) like: "Single node App and DB", "Multi node App and DB"...etc. When we want to deploy some specific scenarios (assembly templates), we are making an instance of that assembly template that is called service and then we operate on it.
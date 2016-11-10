---
title: What is the Dtk?
order: 1
---

# What is the Devops Toolkit (Dtk)

Being able to automatically deploy, upgrade and configure software applications and services has been widely recognized as critical functionality. There is a need for this capability in multiple environments, such as  production, staging, testing and developer sandboxes. 

Some key challenges in providing automation for deploying and upgrading applications and services are that

* The stack to deploy can touch multiple layers that can include networking and storage, infrastructure services like container schedulers or Big Data clusters, application deployment and installation/configuration on virtual or physical nodes. 
* Applications can leverage multiple Internet services that now are being offered at many different levels of abstraction. This makes central glue-code that coordinates and integrates these varying Internet services together as well integrating them with Open Source or commerical software that is installed and configured on nodes.
* Complexity from heterogeneity that arises from different management and configuration tools that are inherited or arise through acquisition
* Decoupling the layers, such as achieving multi-cloud portability where the application code could be written and packaged once while still enabling them to run on alternative Internet services providing node or container deployment

In the area of deployment and configuration, a paradigm that has been getting wide acceptance has gone labled terms such as DevOps and "infrastructure as code". A central tenant is treating infrastructure in a declarative way that can be versioned and stored under source control just like code. One promise of this approach is enabling predictable and repeatable deployment in the form of cookie-cutter deployment templates that are analgous to code.

The DevOps Toolkit (DTK) is a deployment and configuration system in the "infrastructure as code" mold with a key focus on reuse and integration that is designed to address the challenges identified above. It offers a functionality where users can develop, share, version and refine deployment templates. Existing deployment assets such as bash scripts, containers, Puppet manifests can be used as is by wrapping them in a simple but neutral DSL provide by the DTK that unifies across the layers of a stack. These deployment templates can span multiple layers in a stack intergating for example networking, other Internet services, node configuration and application deployment or can handle a specific part. 

The central function that the DTK user performs is deploying templates in a selected environment and then once deployed being able to modify the template to update or upgrade the stack or to terminate or decomission parts or the whole thing.
Key to the DTK design is that the user stages and deploy templates with respect to an environment or lower level service. For example, the same template can be deployed in multiple contexts that provide seperate areas for staging, testing, production, and sandbox per developer. It is a recursive model where for example a template for a Spark cluster can be deployed with respect to a network evironment. In turn Spark applications can be encoded in templates that get deployed with respect to the Spark service. As another example, monitoring infrastructure can be part of a service layer and when applications are deployed with respect to it, monitoring will automatically get configured. A unique feature of the DTK is that it performs automatic customization of a template with respect to the environment it is staged with respect to. This gets us closer to an ultimate goal of using the same templates or common building blocks in development, testing, staging, production to gain predictability in moving between environments in a development and operations workflow.


## Philosohpy

## Influence & Attribution


## Developer Flow

A Typical Dtk Developer flow looks like:

![DTK Diagram]({{site.assetsBaseDir}}/img/diagrams/dtk_diagram_1.png "DTK diagram")


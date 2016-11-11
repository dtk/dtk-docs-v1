---
title: What is the Dtk?
order: 1
---

# What is the Devops Toolkit (Dtk)

The DevOps Toolkit (Dtk) is an automated deployment and configuration system with a key focus on reuse and integration. It fits into the "infrastructure as code" paradigm where infrastructure is treated in a declarative way that can be versioned and stored under source control just like code. One promise of this approach is facilitating predictable and repeatable deployments through the use of cookie-cutter deployment templates, which are the analog to code.

The DTK provides functionality where users can develop, share, version and refine deployment templates. These templates, like code, can be built from lower level templates.  The central functionality that the Dtk user performs is deploying templates with resepct to a selected environment and then once deployed being able to modify the template to update or upgrade the stack or to terminate or decomission parts or the whole deployment. A key capability of the Dtk is that the same template can be deployed in multiple contexts that provide seperate areas for staging, testing, production, and sandboxes per developer. The Dtk automatically customizes the template based on the environment it is deployed with respect to. This gets the user closer to an ultimate goal of using the same templates or common building blocks to gain predictability in moving between environments in an end-to-end development and operations workflow.


# Key deployment problems addressed

The Dtk is designed to address some key complexities and complications that can arise in state of the art deployment systems.

### Coordination across layers of a stack

End to end deployment and configuration can involve multiple technologies and layers such as
* configuring networking and storage,
* provisioning building block Internet services, such as ones for  databases, big data clusters, monitoring, or authorization, 
* installation and configuration on virtual or physical nodes
* code deployment that can have various forms, e.g. installation and configuration on nodes, containers, "serverless code" (e.g AWS  Lambda)

The Dtk provides deployment workflows that can span, coordinate and order all these layers without putting constraints on the solutions used at any of these layers.

### Leveraging existing configuration assets 

A design goal of the Dtk is to leverage existing assets. To that end, the Dtk deployment building blocks are built using existing deployment assets, such as bash scripts, containers, Puppet manifests and is extensible to bring in additional types of assets. All of these assets get wrapped by a simple Dtk Domain Specfic Language (DSL) encoded in yaml that is akin to an object oriented interface that hides the implementation details of the actual code, script, manifests, etc. 

### Integration of configuration, discovery, test, and other actions

The state of the art configuration tools are focused on configuration and deployment actions, and typically provide little or awkward support for other types of relevant actions, such as ones that run smoketests as a workflow proceeds, deploy code, or copy reference datasets to execution environments. Likewise discovery in these systems are typically treated as a separate pre-processing stage or must be down out-of-band to the tool. In contrast the Dtk takes a more flexible approach where workflows are composed of any type of actions that can be ordered in arbitrary ways. The Dtk achieves these objectives by leveraging the advanced action and state model developed in the field of Articial Intelligence (AI) planning. It adopts an approach that coherently integrates state-based deployment approaches with a capability where the user can write or customize execution workflows along with using workflows automatically generated from desired state. 


### Layered services and multi cloud portability

A common goal identified is achieving multi-cloud portability meaning being able to move an application stack with minimal or no modification between service providers offering base services such as networking, storage, and node and container deployment. The Dtk has been designed to address a more general version of this problem by allowing a "layered services approach". Key to the DTK design is that the user can deploy templates with respect to an environment or lower level service. To achieve the typical multi-cloud portability this means that the base networking, storage, and images are encoded as deployment templates, one or more for each service provider. The dtk user first selects and deploys a template associated with base services for a desired service provider.  Once these base services are deployed forming a 'target', a deployment template capturing the application parts only can be deployed with respect to it. The Dtk will automatically customize to the flavor of the base services. 

Being a layared model means in turn a deployment template can be deployed with respect to a target that itself has a target. For example, a template for a Spark cluster can be deployed with respect to a network evironment. In turn Spark applications can be encoded in templates that get deployed with respect to a deployed Spark target. 

This model also allows alternatives for the spark cluster, such as one that binds to a "Spark as a service" cluster. The Spark application deployment template could be written to be agnostic to how the Spark cluster is deployed. The Dtk user makes the deployment choice by selecting whether the Spark application template is spun up with respect to a target capturing a deployed Spark cluster on nodes or alternatively a "Spark as a service" target.


## Developer Flow

A Typical Dtk Developer flow looks like:

## TODO: Rich: will tackle this section next
![DTK Diagram]({{site.assetsBaseDir}}/img/diagrams/dtk_diagram_1.png "Developer Workflow diagram")



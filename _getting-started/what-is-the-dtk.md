---
title: What is the Dtk?
order: 1
---

# What is the Devops Toolkit (Dtk)

The DevOps Toolkit (Dtk) is an automated deployment and configuration system with a key focus on reuse and integration. It fits into the paradigm labeled as DevOps and "infrastructure as code".  A key tenant of this paradigm is treating infrastructure in a declarative way that can be versioned and stored under source control just like code. One promise of this approach is enabling predictable and repeatable deployment in the form of cookie-cutter deployment templates.

The DTK provides functionality where users can develop, share, version and refine deployment templates. These templates, like code, can be built from lower level templates.  The central functionality that the Dtk user performs is deploying templates with resepct to a selected environment and then once deployed being able to modify the template to update or upgrade the stack or to terminate or decomission parts or the whole thing. A key capability is that the same template can be deployed in multiple contexts that provide seperate areas for staging, testing, production, and sandbox per developer. The Dtk automatically customizes the template based on which environment it is deployed with respect to. This gets the user closer to an ultimate goal of using the same templates or common building blocks to gain predictability in moving between environments in an end-to-end development and operations workflow.


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

A design goal of the Dtk is to leverage existing assets. To that end, the Dtk deployment building blocks  are built using existing deployment assets, such as bash scripts, containers, Puppet manifests and is extensible to bring in additional types of assets. All of these assets get wrapped by a simple Dtk DSL that is akin to an object oriented interface that hides the implementation details of the actual code, script, manifests, etc. 

### Integration of configuration, discovery, test, and other actions

The state of the art configuration tools are focused on configuration and deployment actions, and typically provide little or awkward support for other types of relevant actions, such as ones that do things like run smoketests as a workflow proceeds, deploy code, or copy reference datasets to execution environments. Likewise discovery in these other systems are typically treated as separate pre-processing or out-of-band stages. In contrast the Dtk takes a more flexible approach where workflows are composed of any type of actions that can be ordered in arbitrary ways. The Dtk achieves these objectives by leveraging the advanced action and state model developed in the field of Articial Intelligence (AI) planning. It adopts an approach that coherently integrates state-based deployment approaches with a capability where the user can write or customize execution workflows along with using workflows automatically generated from a description of desired state. 


### Layered services and multi cloud portability

A common goal identified is achieving multi-cloud portability. The Dtk has been designed to address a more general version of this problem by allowing a "layered services approach". Key to the DTK design is that the user can deploy templates with respect to an environment or lower level service. For example, the same template can be deployed in multiple contexts that provide seperate areas for staging, testing, production, and sandbox per developer. It is a recursive model where for example a template for a Spark cluster can be deployed with respect to a network evironment. In turn Spark applications can be encoded in templates that get deployed with respect to the Spark service. As another example, monitoring infrastructure can be part of a service layer and when applications are deployed with respect to it, monitoring will automatically get configured. 

### Note: alternative description for "Layered services and multi cloud portability"

A common goal identified is achieving multi-cloud portability. The Dtk has been designed to address a more general version of this problem by allowing a "layered services approach". The Dtk allows an end user to treat a deployment stack as a single unit or alternatively organized in a layered fashion providing much flexibility.

 As an example consider an application with its need for a database. Given the specific database technology choice there are typically multiple deployment options such as installing software on nodes or use of a database as a service. The Dtk user can organize the deployment logic tailored for these different cases. 
* If the user choices a database solution by installing software he or she might build a single deployment template that configures the network, spins up nodes and installs the database and application. 
* If the user chooses a database as a service solution, the user can build a deployment template that configures the network, spins up nodes and installs the application and has dtk actions that provisions the database through rest calls
* If the user chooses a complete "serverless solution", the user can build a deployment template that uses rest calls to configure the database and push code for the application to a serverless service offering
* If the user wants the flexibility to switch between solutions, he or she can break up deployment into multiple layers, such as one for the application that can work with the different database solutions. The user would also have two or more different deployment templates for the different database solutions. The user then can deploy the database template and then would deploy the application template linked to,the database as a lower level service


## Developer Flow

A Typical Dtk Developer flow looks like:

## TODO: Rich: will tackle this section next
![DTK Diagram]({{site.assetsBaseDir}}/img/diagrams/dtk_diagram_1.png "Developer Workflow diagram")



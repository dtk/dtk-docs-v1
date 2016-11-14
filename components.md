---
title: Dtk Components
permalink: components/index
---

# Dtk Components

Dtk components are the base building blocks that are composed to form logic to deploy, configure and manage applications and services. A component can refer to anything that can be deployed, managed, or discovered in a cloud or internal data center. Some typical things components refer to are

* A package that gets installed on a node and then configured and services started/stopped if applicable
* A resource in a cloud service, such as a vpc subnet, kinesis stream or lambda function for AWS
* Application code in the different forms, such as code that is installed, code submitted to a cluster or cloud service, or deployed as containers
* A task that gets run on a cluster
* A reference dataset (e.g., in S3) that is being accessed or copied

A Dtk component consists of
* the implementation - the scripts, code, configuration logic (e.g. puppet class or definition) that performs the needed deployment, configuration, discovery, or management actions
* the interface - a Dtk DSL description that serves as a neutral interface to the code that provides a set of actions that can be performed on the component and attributes that capture desired or configured state.  This is modeled after the standard Object Oriented interface where you have objects and methods defined on them.

A Dtk user can invoke an action on a single component or invoke an assembly workflow that coordinates a set of actions, which can span multiple layers in a complex stack.  When an action is executed, the Dtk dispatches the action to either a selected node where the implementation code is run or runs the action's implementation code in a Dtk internal container. This latter case is used, for example, when the implementation code is calling rest services interacting with resources deployed on an Internet or networked service.

## Component Actions

Each Dtk component must have a 'create' action defined, optionally has a delete action and can have arbitrary component-specific actions defined. The create and delete actions are analogous to constructors and destructors in the OO world.
The user has the flexibility to define a create cation in different ways such as
* an action that creates a new resource
* an action that discovers an existing resource
* an action that just 'stages' the component that then can be actually deployed by following up with another action on the component that does the actual deployment

A typical pattern is to have the create action encode 'idempotent’ semantics, meaning that once created, the create action can be run again after changing the component's attributes. This subsequent create call will try to bring the actual resource to the desired state reflected in the attribute settings. Consequently, we will sometimes refer to the create action as a 'converge' action since it tries to "converge to a state". The Dtk user has flexibility to define the create action so it only works when creating the resource from scratch or only works for certain attribute changes, raising errors if changes are made that are not supported,.

If the user defines a delete action then this is executed when the user deletes the component from the deployment environment. Sometimes a delete action is not necessary, such as components that get installed on nodes. If the node itself is deleted there may be no need to delete the components inside the component. Conversely when provisioning cloud services it is typically important to destroy the resources that are created when decommissioning the deployment.

The Dtk user has flexibility to also define other types of actions to things such as
* return information about component's actual state
* action that performs a test and returns the results, such as use of smoke tests interspersed in a workflow that can abort execution upon failure
* actions that copy or backup datasets

## Component Attributes

A component’s attributes typically represents desired or configured state to achieve when the component is created. When any action is executed it has access to all the attributes that are set on the component as input much the same way in OO languages  method calls have access to an objects state variables. A Dtk action can also set component attributes after execution. This is the mechanism that the Dtk uses for discovery. As an example a workflow can first have a AWS vpc component that discovers the relevant AWS vpc id, which can be feed to a subsequently executed vpc subnet component that creates a vpc subnet and needs its parent’s id. 

## Component dependencies

A key feature of the Dtk is that a component can be given dependencies, such as one that says an app component requires a db component. By associating the dependencies with a reusable component, these dependencies get inherited by the environments in which they leave. This enables the Dtk to both raise violations when dependencies are missing as well as when possible to ‘auto complete’ dependencies, such as automatically binding a component to a database in an environment where it is deployed. This is a form of service discovery. In the Dtk DSL there are two constructs that pertain to component dependencies:
* A dependency that says that a component requires another component ort a choice between components (e.g., an app may require a Postgresql, MySQL, Oracle database server)
* ‘Link defs’ which capture when a component has a dependency on another one how their attributes should be synched. An example is a link def that captures that ‘db_port’ on the app component gets its value from attribute ‘port’ on a Postgresql component. This is an ETL-like specification that enables the Dtk user to capture when linking to a MySQL db as an alternative that it must use the attribute on the MySQL that denotes its listening port, but may be named differently than ‘port’.


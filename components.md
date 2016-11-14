---
title: Dtk Components
permalink: components/index
---

# Dtk Components

Dtk components are the base building blocks that are composed to form logic to deploy, configure and manage applications and services. A component can refer to anything that can be deployed, managed, or discovered in a cloud or internal data center. Some typical things components refer to are

* A package that gets installed on a node and then configured and services started/stopped if applicable
* A resource in a cloud service, such as a AWS vpc, vpc subnet, security group, etc
* Application code in the different forms, such as code that is installed, code submitted to a cluster or cloud service, or deployed as containers
* A task that gets run on a cluster
* A reference dataset (e.g., in S3) that is being accessed or copied

A Dtk component consists of
* the implementation - the scripts, code, configuration logic (e.g. puppet class or definition) that performs the needed deployment, configuration, discovery, or management actions
* the interface - a Dtk DSL description that serves as a neutral interface to the code that provides a set of actions that can be performed on the component and attributes that capture desired or configured state.  This is modeled after the standard Object Oriented interface where you have objects and methods defined on them.

As the Dtk user invokes an action on a component or runs a workflow that coordinates a set of actions, the Dtk dispatches the action to either a selected node where the implementation code is run or runs the action's implementation code in a Dtk internal container. This latter case is used, for example, when the implementation code is designed to call rest services interacting with an Internet or networked service.

## Component Actions

Each Dtk component must have a 'create' action defined, optionally has a delete action and can have arbitrary component-specfic actions also defined. The create and delete actions are analogous to constructors and destructors in the OO world.
The user has the flexability to define a create cation in different ways such as
* action that creates a new resource
* action that discovers an exeisting resource
* action that just 'stages' the component that then can be actually deployed with follow up action that does deployment

A typical pattern is to have the create action encode 'idempotent semantics' meaning that once created, the create action can be run again after changing the component's attributes. This subsquent create call will try to bring the actual resource to the desired state reflected in the attribute settings. Consequently, we will sometimes refer to the create action as a 'converge' action since it tries to "converge to a state". The Dtk user has flexibility to define the create action so it only works when creating the resource from scatch or only works for certain attribute changes, raisiing errors if changes are made that are nopt supported,

If the user defines a delete action then this is executed when the user deletes the compoent from an assembly. Sometimes a delete action is not necessary, such as components that get installed on nodes. If the node itself is deleted there may be no need to delete the components inside the component. Conversely when provisioning cloud services it is important to destroy the resources that are created.

The Dtk user has flexibility to also define other types of actions to things such as
* return information about component's actual state
* action that performs a test and then results the results, such as use of smoktested interspersed in a workflow that can abort execution upon failure
* actions that copy or backup datasets


## Component Attributes

TODO: say that attributes typically respresent desired or configured state to achibe.

Note: say that action behabior is can be a function of attributes so thay can serve as input or output and ...
## Component dependencies




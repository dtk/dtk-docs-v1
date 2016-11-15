---
title: Actions
order: 20
---

# Component Actions

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

A Dtk user can invoke an action on a single component or invoke an assembly workflow that coordinates a set of actions, which can span multiple layers in a complex stack.  When an action is executed, the Dtk dispatches the action to either a selected node where the implementation code is run or runs the action's implementation code in a Dtk internal container. This latter case is used, for example, when the implementation code is calling rest services interacting with resources deployed on an Internet or networked service.





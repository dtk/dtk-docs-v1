---
title: Dtk Components
permalink: components/index
---

# Dtk Components

Dtk Components are the base building blocks that are composed to form logic to deploy, configure and manage Applications and Services. Some typical things Components can refer to are:

* Application code in the different forms, such as code that is installed, code submitted to a cluster or cloud service, or deployed as containers
* A package that gets installed on a node and then configured and services started/stopped if applicable
* A resource in a cloud service, such as a vpc subnet, RDS database or Lambda function for AWS
* A task that gets run on a cluster
* A reference dataset (e.g., in S3) that is being accessed or copied

A Dtk Component consists of
* the implementation - the scripts, code, configuration logic (e.g. puppet class or definition) that performs the needed deployment, configuration, discovery, or management actions
* the interface - a Dtk DSL description that serves as a neutral interface to the code that provides a set of actions that can be performed on the component and attributes that capture desired or configured state.  This is modeled after the standard Object Oriented interface where you have objects and methods defined on them.



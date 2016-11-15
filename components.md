---
title: Dtk Components
permalink: components/index
---

# Dtk Components

Components are the basic Dtk building blocks that are composed to provide the capability to deploy, configure and manage applications and services. Some typical things Components can refer to are:
* Application code deployed in the different forms, such as code that is installed, code submitted to a cluster or cloud service, or deployed as containers
* Common infrastructure pieces installed on nodes, such as app servers, load balances, proxies, database servers and clients, cluster components like Spark masters and slaves
* Resource in a cloud service, such as for AWS, vpc subnets, routing tables and security groups, RDS databases or Kinesis streams
* A task that gets run on a cluster
* A reference dataset (e.g., in S3) that is being accessed or copied

A Dtk Component consists of the scripts, code, configuration logic (e.g. puppet class or definition) that perform the needed deployment, configuration, discovery, or management actions and a Dtk DSL description that serves as a language-neutral interface for the code or scripts. A component's DSL description specifies
* Attributes - which are set to capture the desired, configured, or actual state of the component
* Dependencies - which capture relationships like an app component is required to be connected to a database server and how the app and database server attributes should be synchronized to for example make sure the application can listen on the appropriate host address and port to reach the db server
* Actions - which are Dtk language neutral terms that get bound to the code and scripts

The relationship between a component's Dtk DSL description and the actual code and scripts is analagous to the Object Oriented interface/implemntation distiction where Components correspond to classes, Action to method names and the code/scripts to the objects's implementation.

Open question: where should a high level view of a component's dsl be given that tie sthe attribute, action and dependency pieces together 

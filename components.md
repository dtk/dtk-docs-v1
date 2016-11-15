---
title: Dtk Components
permalink: components/index
---

# Dtk Components

Components are the basic Dtk building blocks that are composed to provide the capability to deploy, configure and manage applications and services. Some typical things Components can refer to are:
* Application code deployed in the different forms, such as code that is installed, code submitted to a cluster or cloud service, or deployed as containers
* Common infrastructure pieces, such as app servers, load balances, proxies, database servers and clients, cluster components like Spark masters and slaves
* Resource in a cloud service, such as for AWS, vpc subnets, routing tables and security groups, RDS databases or Kinesis streams
* Tasks that get run on clusters or run as chron jobs
* A reference dataset (e.g., in S3) that is being accessed or copied

A Dtk Component consists of the bash scripts, code, or configuration logic (e.g. puppet class or definition) that perform the needed deployment, configuration, discovery, or management actions and a Dtk DSL description that serves as a language-neutral interface that wraps the code or scripts. A component's DSL description specifies
* Attributes - which capture the desired, configured, or actual state of the component
* Dependencies - which capture relationships like an app component is required to be connected to a database server and how the app and database server attributes should be synchronized to for example make sure the application can listen on the appropriate host address and port to reach the db server
* Actions - which are Dtk language neutral terms that get bound to the code and scripts

The relationship between a component's Dtk DSL description and the actual code and scripts is analagous to the Object Oriented interface/implementation distinction where a Component corresponds to a class, an Actions to a method name, and an action's code/scripts to the object's implementation.

Open question: where should a high level view of a component's dsl be given that tie sthe attribute, action and dependency pieces together 

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

A Dtk Component consists of
* Attributes - which capture the desired, configured, or actual state of the component
* Dependencies - which capture relationships like an app component is required to be connected to a database server and how the app and database server attributes should be synchronized to for example make sure the application can listen on the appropriate host address and port to reach the db server
* Actions - which are the bash scripts, code, or configuration logic (e.g. puppet class or definition) that perform the needed deployment, configuration, discovery, or management operations

The type of code or configuration language that can be used is extensible. Currently Bash, Puppet, and Ruby are supported. We refer to these as 'language providers'

## Dtk component DSL 
Each component has a Dtk DSL description with high level form

TODO: Provide a DSL skeleton that shows the possible sections; then the sub sections on attributes, actions and dependencies can just focus on specific snippets

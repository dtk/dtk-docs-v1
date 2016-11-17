---
title: Dkt Service Instances & Targets
permalink: targets/index
previous_page:
  url: /assemblies/workflows
next_page:
  url: /targets/aws
---

# Dtk Service Instance

Unique to the Dtk is its approach to Service management in a manner modeled after Object Oriented programming.  The Dtk treats all the content in your Modules (ie: Components, Assemblies, Workflows, etc) as definitions and templates that you will be deploying and managing.  Upon staging and deployment of an [Assembly]({{site.siteBaseDir}}/assemblies) the Dtk instantiates a Service Instance to be used for ongoing management and editing and containing "instance copies" of all objects you are deploying.  Lets say you have an application Assembly for a 3 node deployment.  If you stage and deploy that Assembly twice, you will have two running Services, as well as two Service Instance copies to work with.

Service Instances are handy in that they automatically provided a protected sandbox for you and are isolated from any change in the related Module content you might be deploying from.  In the background the Dtk makes copied references for the instance of all the leveraged Modules which makes so work can continue on your core IT assets without having to worry about trashing your running Services, squashing commits of team members, or coming up with specific branching strategies..., its all handled behind the scenes for you.  The other great aspect of Service Instances is that any special handling or thinking you might have done for "environments" in other systems goes away with the maintained Service Instance isolation.

Once the Service Instance is created you not only have isolated copies of the Modules you are leveraging, you also get a new Service Instance repository which is a version controlled file representation in the state of your running Service(s).  When you want to run [Actions]({{site.siteBaseDir}}/components/actions) or change the desired state of your Service, simply edit the model file(s) in your instance repository directory, or leverage edit commands via the Dtk Client, and run the **converge** Action.  The Dtk will commit your edits to the Catalog and execute any required Action or Workflow and update to the desired state.

## Targets

A basic functionality provided by the Dtk is to enable applications and services to be deployed with respect to lower level services that provide needed base services or context. The assembly templates that provide the lowest-level base services are referred to as 'target' assemblies.  Like any other assembly they get staged forming a service instance, or what we will sometimes refer to as a "target instance". In their simplest form targets are used to enable the Dtk user to select a particular cloud service to deploy with respect to, which will have details that differ accross cloud providers. For example, to deply with respect to an AWS VPC, the user could first select an assembly from the 'aws/network' module in the Dtk community repo. The different assembly and parameter choices in this module gives choices with respect to
* authorization methods - using IAM node profiles vs explicitly putting in user credentials for an existing IAM user, and 
* networking - whether to use a VPC subnet that has been created or to create one when the target is staged and deployed. 
Note that these options are for this particular 'aws/network' module and that Dtk users can customize this module or create a new one to handke additional or different alternatives with reagrds to base AWS deployment context. To treat new cloud providers the user would build a new mdoule with assemblies encoding the provider's specfics.  

After a target assembly has been staged and deployed to create a target instance, an assembly template that captures the application part, but is agnostic to cloud provider can be staged to form a service instance. In this case, the 'dtk stage' command takes a command line option that points to the target instance. The Dtk wil then create a service insatnce that gets automatically customizied to the target.  


---
title: Dkt Service Instances & Targets
permalink: targets/index
---

## Dtk Service Instance

A service instance acts as a deployment context for an application or service. A service instance is created when the Dtk user issues the 'dtk stage' command, which creates a new deployment instance from a user-selected assembly template.  The same assembly template can be used to create multiple instances of the same application or service, for example, in different environments (e.g., production, staging, testing) or to provide a sandbox per developer.  The stage command creates the service instance in 'staged' state meaning that the Dtk provides a context for the user to manage the service instance, but the actual deployment on a cloud Internet service(s) or internal datacenter(s) has not yet been executed. Once the service instance is created, the user then can execute actions that bring about the actual deployment. Before executing actions that cause the actual deployment, the user can make changes to the service instance to, for example, put in deployment-specfic parameters that cannot be automtically determined or to do some manual customization for the specfic instance.  

After the first deployment action, the user could make changes to the service instance, which serves to provide a new desired state. To cause the actual change to take place the user would then execute the 'converge' action, which will try to bring the actual deployment in line with the new service instance state. The user also has at her or her disposal a set of actions defined on the service instance that specfically defined actions for the service or application and do things like query the state of the deployment, perform tests, copy datasets.

#### Open question: should we have simple state diagram here showing links for commands taht do stage, converge, modify service instace, ...

## Targets

A basic functionality provided by the Dtk is to enable applications and services to be deployed with respect to lower level services that provide needed base services or context. The assembly templates that provide the lowest-level base services are referred to as 'target' assemblies.  Like any other assembly they get staged forming a service instance, or what we will sometimes refer to as a "target instance". In their simplest form targets are used to enable the Dtk user to select a particular cloud service to deploy with respect to, which will have details that differ accross cloud providers. For example, to deply with respect to an AWS VPC, the user could first select an assembly from the 'aws/network' module in the Dtk community repo. The different assembly and parameter choices in this module gives choices with respect to
* authorization methods - using IAM node profiles vs explicitly putting in user credentials for an existing IAM user, and 
* networking - whether to use a VPC subnet that has been created or to create one when the target is staged and deployed. 
Note that these options are for this particular 'aws/network' module and that Dtk users can customize this module or create a new one to handke additional or different alternatives with reagrds to base AWS deployment context. To treat new cloud providers the user would build a new mdoule with assemblies encoding the provider's specfics.  

After a target assembly has been staged and deployed to create a target instance, an assembly template that captures the application part, but is agnostic to cloud provider can be staged to form a service instance. In this case, the 'dtk stage' command takes a command line option that points to the target instance. The Dtk wil then create a service insatnce that gets automatically customizied to the target.  


### Layered services and self contained assemblies

#### Open question: shoudl this go in the adbvances section; or have whole thing or pieces kept here

The Dtk provides the flexibility to design assembly templates that are self contained, for example, having components that will provision both the application and the base provider services or to design assembly templates that breaks things into layers. Where a self contained assembly template provides simplicity, which may be warranted for the deployment environment, breaking into layers provide capabilities, such as
* A target can encode in one place authorization that gets set once when target staged and deployed and then any assembly staged with respect to it would not need to deal with credentials
* If user wants to use the same application logic for different cloud providers then breaking into layers gives this flexability
* Providing a 'layered service' model where for example there is a target instance that provides base AWS networking and authorization services; on top of this, the user stages and deplys an assembly template producing a service instance that brings up a cluster service or comntainer scheduler; on top of this cluster or container service the user can use assembly templates that just deal with the applications that should run on the cluster or scheduler.
* Breaking up a deployment into multiple services instnaces gives the potential to provide administartive domains for different areas of a deployment. Logic at the lower level services can encode along with how the service is configured also access rules and quotas that constrain the use of the shared service.



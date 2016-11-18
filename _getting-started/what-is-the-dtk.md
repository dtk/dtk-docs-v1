---
title: What is the Dtk?
order: 1
permalink: /getting-started/what-is-the-dtk/index
---

# What is the Devops Toolkit (Dtk)?
<br/>
The DevOps Toolkit (Dtk) is an automated deployment and configuration system for services, applications & infrastructure with a key focus on reuse, integration & collaboration.  The Dtk's state-based declarative way of treating services and infrastructure is versioned and stored under a built in source controlled Service Catalog along side your applications that need to be deployed, configured and tested.

<br/><br/>

### Unified Integration & Continual Improvement 
<div class="container" style="width:100%">
    <div class="row" style="display: flex; align-items: center;">
        <div class="col-md-3" style="text-align: center;">
            <img src="{{ site.url }}{{ site.siteBaseDir }}/assets/img/reuse-asset-icon-03.png" style="margin: 20px auto;"/>
        </div>
        <div class="col-md-9" style="">
            A primary design goal of the Dtk is to leverage and unify your existing IT/developer assets and processes.  Many solutions promise great features for automation and deployment only to have you learn custom languages and rewrite your code to fit into their platforms.  The Dtk way is to wrap and integrate with any script/language and be the unifying management hub.  The Dtk fosters and promotes a continual improvement mindset and can re-use ANY asset such as Bash/Ruby/Python/etc scripts, Puppet modules, and containers to name a few.  Leveraging a simple wrapper DSL encoded in yaml, the Dtk's Component Model provides something akin to an object oriented interface that hides the implementation details of the actual code, script, manifests, etc.  Once your existing assets are "Dtk Enabled" it becomes easy to improve your assets and IT processes while promoting sharing and collaboration across your teams via your Dtk Service Catalog or share across the Dtk Network with others outside your org.
        </div>
    </div>
</div>
<br/><br/>

### Composable Services & Infrastructure
<div class="container" style="width:100%">
    <div class="row" style="display: flex; align-items: center;">
        <div class="col-md-3" style="text-align: center;">
            <img src="{{ site.url }}{{ site.siteBaseDir }}/assets/img/compose-icon-01.png" style="margin: 20px auto;"/>
        </div>
        <div class="col-md-9" style="">
	Building on the Dtk's re-usable Component Model, it allows you to then compose those building blocks into higher level Applications and Services using the Dtk Assembly Model.  Much like how the Dtk's Component model facilitates re-use and sharing at the asset/resource level, Assemblies provide the same for complex Applications and Services.
	<br/><br/>
	Rather than requiring a Service to be managed in a monolithic manner the Dtk allows you to take a Layered Services approach with each layer being re-usable much like its lower level Components.  This would allow for instance one to deploy a network layer first, followed by a cluster or container scheduler, and finally the application/service.  If you decided later to switch or try out a new scheduler you would only have to replace that particular layer.
        </div>
    </div>
</div>
<br/><br/>


### Flexible & Extensible Workflow and Actions
<div class="container" style="width:100%">
    <div class="row" style="display: flex; align-items: center;">
        <div class="col-md-3" style="text-align: center;">
            <img src="{{ site.url }}{{ site.siteBaseDir }}/assets/img/flexibility-icon-02.png" style="margin: 20px auto;"/>
        </div>
        <div class="col-md-9" style="">
	There are plenty of tools that provide deployment and workflow functionality.  Typically these systems you either start from zero and hand build your Workflows/run-books from scratch, or they box into a pre-set hard coded pipeline and stages.  Embedded into the Dtk is a powerfull Workflow and task execution engine that auto-generates Workflows for you as you change your state/models, while allowing you to hand customize as you wish and providing an infinitely extensible framework to implement any custom Workflow/Action you wish.  Having issues with a highly complex deployment run, go ahead and stich in a custom smoke test that will stop a run on failure so you can debug further, or implement a custom Workflow for your specific canary rolloout strategy.  The Dtk's Workflow and Action functionality can coordinate across all layers in a deployed Service without putting constraints on your implementations.
        </div>
    </div>
</div>
<br/><br/>


If you have said things like this to yourself:

  * I wish I had a deployment and automation tool that works across physical, virtual, container and serverless infrastructures 
  * I wish our processes for testing infrastructure and services was better and repeatable across environments
  * I really like tool XYZ but it assumes its managing ALL my infrastructure and I dont want it to trash things by accident
  * I wish ops could provide built in monitoring to make my testing and debugging easier in non-production environments
  * Tool ABC is handy but I wish it didnt have such a rigid pre-defined workflow
  * My environment has a variety of configuration and deployment technologies, but they are siloed, and I want them better integrated
  * Why do I have to copy/paste and hand edit things so often whenever I want a slight variation or move to a new environment

Then you will find the Dtk quite usefull in your day to day development and operations efforts.  To learn more you can start reading about how the Dtk object model works, or if you like to experiment you can jump right into the Quickstart Guide.

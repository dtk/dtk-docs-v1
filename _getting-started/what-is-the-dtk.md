---
title: What is the Dtk?
order: 1
---

# What is the Devops Toolkit (Dtk)

The DevOps Toolkit (Dtk) is a an automated deployment and configuration system for both Services & infrastructure with a key focus on reuse, integration & collaboration.  The Dtk's state-based declarative way of treating Services and infrastructure is versioned and stored under a built in source controlled Service Catalog along side your applications that need to be deployed, configured and tested.

    ---Temp Stub, might remove
    If you have said things like this to yourself, the Dtk can help you out

    * I wish I had a single deployment and automation tool that works across physical, virtual, container and serverless infrastructures 
    * This tool looks really cool but it assumes its managing ALL my infrastructure and I dont want it to trash things by accident
    * Whats the best way to make this IT asset re-usable for others, while being able to work in different environments?
    * I wish ops could provide built in monitoring to make my testing and debugging easier in non-production environments
    * This system is great but wish it didnt have such a rigid pre-defined workflow and non-customizeable actions 
    * Why do I have to copy/paste and hand edit things so often whenever I want a slight variation or move to a new environment
    * I wish our processes for testing infrastructure and services was better and repeatable across environments
    * I wish person/team XYZ would stop squashing our teams commits and follow our proper branch and rebase strategy


***This approach facilitates predictable and repeatable deployments.

## Asset Re-Use & Continual Improvement 

<div class="container" style="width:100%">
    <div class="row">
        <div class="col-md-3" style="text-align: center;">
            <img src="{{ site.url }}/assets/img/reuse-asset-icon-01.png" style="margin: 20px auto;"/>
        </div>
        <div class="col-md-9" style="vertical-align: middle;">
            A primary design goal of the Dtk is to not re-invent the wheel & leverage existing IT/developer assets.  Many solutions promise great features for automation and deployment only to have you learn custom languages and rewrite your code to fit into their platforms.  The Dtk fosters and promotes a continual improvement mindset and can re-use ANY asset such as bash/ruby/python/etc scripts, Puppet modules, and containers to name a few.  Leveraging a simple "wrapper" DSL encoded in yaml, the Dtk's Component model provides something akin to an object oriented interface that hides the implementation details of the actual code, script, manifests, etc.  Once your existing assets are "Dtk Enabled" it becomes easy to improve your assets and IT processes while promoting sharing and collaboration across your teams.
        </div>
    </div>
</div>

### Layered Service Approach

The Dtk takes an opinionated "Service Layer" approach to any Infrastructure and Service that is deployed and managed from it.  Much like how the Dtk's Component model provides faciliates re-use and sharing at the asset/resource level, its Service Layer approach provides a similar re-use model via its Assembly model for complex Applications and Services.  The general idea is that any Layer once implemented is re-usable and portable in other variations and infrastructure environements requiring zero change.  

An example is achieving portability across vSphere, Azure, and AWS with being able to deploy/move a Service with zero or minimal modification between service providers offering base resources such as networking, storage, and node/container deployment.  As Layers are designed and implemented the Dtk provides deployment Workflows and can carry out Actions that can span, coordinate and order all these layers without putting constraints on your implementations.

### Flexible & Extensible Workflow and Actions

There are plenty of tools that provide deployment and workflow functionality.  Typically these systems you either start from zero and hand build your Workflows/run-books from scratch, or they box into a pre-set hard coded pipeline and stages.  Embedded into the Dtk is a powerfull Workflow and task execution engine that auto-generates Workflows for you as you change your state/models, while allowing you to hand customize as you wish and providing an infinitely extensible framework to implement any custom Workflow/Action you wish.  Having issues with a highly complex deployment run, go head and stich in a custom smoke test that will stop a run so you can debug further, or implement a custom Workflow for your specific canary rolloout strategy.


#### MOVE THIS TO WORKFLOW SECTION/PAGE

The Dtk achieves these objectives by leveraging the advanced action and state model developed in the field of Articial Intelligence (AI) planning. It adopts an approach that coherently integrates state-based deployment approaches with a capability where the user can write or customize execution workflows along with using workflows automatically generated from desired state. 

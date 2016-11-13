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

### Asset Re-Use & Continual Improvement 

<div class="container" style="width:100%">
    <div class="row" style="">
        <div class="col-md-3" style="text-align: center; vertical-align: middle;">
            <img src="{{ site.url }}/assets/img/reuse-asset-icon-01.png" style="margin: 20px auto;"/>
        </div>
        <div class="col-md-9" style="vertical-align: middle; line-height: 10px;">
            A primary design goal of the Dtk is to not re-invent the wheel & leverage existing IT/developer assets.  Many solutions promise great features for automation and deployment only to have you learn custom languages and rewrite your code to fit into their platforms.  The Dtk fosters and promotes a continual improvement mindset and can re-use ANY asset such as bash/ruby/python/etc scripts, Puppet modules, and containers to name a few.  Leveraging a simple "wrapper" DSL encoded in yaml, the Dtk's Component model provides something akin to an object oriented interface that hides the implementation details of the actual code, script, manifests, etc.  Once your existing assets are "Dtk Enabled" it becomes easy to improve your assets and IT processes while promoting sharing and collaboration across your teams.
        </div>
    </div>
</div>

### "Composable service" capability

The Dtk provides a "Composable Service" capability to deployment.  Much like how the Dtk's Component model facilitates re-use and sharing at the asset/resource level, the Dtk provides a similar re-use model at the service layer via its 'Assembly model'. Rather than requiring a complex application or service to be modeled and managed as a single unit, a user can also model in terms of composable lower-level services. This allows a user to break into re-usable and portable pieces the various layers and aspects of an end-to-end deployment, such as network and storage, cluster or container scheduler, monitoring infrastructure, and the applications themselves.

While lower level sevices can be hierachically composed to form a wide spanning assembly, the DTk also provides the ability to use a 'layered service' approach which facilitates portability. An example is achieving portability across AWS, vSphere, Azure, Google, etc base services. A Dtk assembly for each service provider can be constructed. To enable deployment to any or a combination these targets, the user would first deploy one or more of these base provider assemblies. Application assemblies that are agnostic to service provider then can be automatically bound to a chosen service provider. This is achieved by using the Dtk's unique capability to deploy an assembly with respect to another previously deployed assembly that serves as the deployment context.

As Layers are designed and implemented the Dtk provides deployment Workflows and can carry out Actions that can span, coordinate and order all these layers without putting constraints on your implementations.


### Flexible & Extensible Workflow and Actions

There are plenty of tools that provide deployment and workflow functionality.  Typically these systems you either start from zero and hand build your Workflows/run-books from scratch, or they box into a pre-set hard coded pipeline and stages.  Embedded into the Dtk is a powerfull Workflow and task execution engine that auto-generates Workflows for you as you change your state/models, while allowing you to hand customize as you wish and providing an infinitely extensible framework to implement any custom Workflow/Action you wish.  Having issues with a highly complex deployment run, go head and stich in a custom smoke test that will stop a run so you can debug further, or implement a custom Workflow for your specific canary rolloout strategy.


#### MOVE THIS TO WORKFLOW SECTION/PAGE

The Dtk achieves these objectives by leveraging the advanced action and state model developed in the field of Articial Intelligence (AI) planning. It adopts an approach that coherently integrates state-based deployment approaches with a capability where the user can write or customize execution workflows along with using workflows automatically generated from desired state. 

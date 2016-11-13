---
title: Dkt Modules
permalink: modules/index
---

# Dtk Modules

Dtk modules handle dependency management and are the base units that get versioned. They allow Dtk users to bundle up related configuration and deployment logic into a manageable unit. They also can contain the code being deployed as well as assets like Dockerfiles with their supporting directories. This serves to closely connect deployment logic and management scripts with the actual code getting deployed and managed.

Dtk Modules are analogous to npm modules in nodejs or gems in ruby with one major difference in that each module can include code and configuration logic of any or mixed types, such as ruby, python, nodejs, bash scripts, puppet manifests, etc.  For instance, you can take your ruby app, add some rake tasks as well as config management scripts to allow people to deploy and manage your app. 

To handle this multi-language environment the modules contain simple "wrapper" DSL, which provides something akin to an object oriented interface that hides the implementation details of the actual code, script, manifests, etc.  This enables the Dtk to expose deployment and management workflows in a language agnostic way that hide the fact that the actual code behind the implementation can vary from step to step.

## Module directory structure

The Dtk user interacts with modules in the form of directories that can have arbitrary nested structure that get loaded on the client machine. Each module has a top level DSL file 'dtk.module.yaml' encoded in yaml that can be broken into multiple files or kept as a single file. Along with the DSL file(s), the module directoy contains the code, script, manifests etc that implement the configuration and management functions and optionally the code being deployed. The Dtk modules allow the code and scripts to be placed anywhere in the directory structure which enables the process of being able to take an existing git project and "Dtk enabling it" by adding Dtk files and leaving the git project unchanged except for these additions.

## Top level Dtk module constructs
The top level Dtk concepts that DSL encodes are
* **components** - ..
* **assemblies** - ..
* **workflows** - ..   

Todo: ....

## Sharing & Collaboration

Modules can be shared and collaborated on with team members via your Dtk Server and publically shared if published to the Dtk Catalog which is the global Service Catalog for Dtk users.


## Versioning

By default when a module is created it just has its "master" version, corresponding to the master git branch.  As changes are made and you wish to publish specific working versions for others to leverage you simple run:

{% highlight bash linenos %}
//TODO: put versioning commands here

~/dtk-modules/foo-module$ dtk version 1.2.3
{% endhighlight %}

Its that simple.  Anyone with a dependency on your `foo-module` Module will now get the latest when they install/update their dependencies.  More details on versioning and dependencies can be found in the "Publishing & Sharing Dtk Modules" section.

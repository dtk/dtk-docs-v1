---
title: Dtk Assemblies
permalink: assemblies/index
---

## Dtk Assemblies

Dtk modules handle dependency management and are the base units that get versioned. They allow Dtk users to bundle up related configuration and deployment logic into a manageable unit. They also can contain the code being deployed as well as assets like Dockerfiles with their supporting directories. This serves to closely connect deployment logic and management scripts with the actual code getting deployed and managed.

Dtk Modules are analogous to npm modules in nodejs or gems in ruby with one major difference in that each module can include code and configuration logic of any or mixed types, such as ruby, python, nodejs, bash scripts, puppet manifests, etc.  For instance, you can take your ruby app, add some rake tasks as well as config management scripts to allow people to deploy and manage your app. 

To handle this multi-language environment the modules contain simple "wrapper" DSL, which provides something akin to an object oriented interface that hides the implementation details of the actual code, script, manifests, etc.  This enables the Dtk to expose deployment and management workflows in a language agnostic way that hide the fact that the actual code behind the implementation can vary from step to step.


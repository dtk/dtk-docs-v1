---
title: Dkt Modules
permalink: modules/index
---

# Dtk Modules

Modules are how the Dtk deals with dependency management and allows developers to bundle up their applications, services and related Components.  Dtk Modules are analogous to npm modules in nodejs or gems in ruby with one  major difference in that Dtk Modules are language agnostic and can manage/contain code of any type whether it be ruby, python, bash scripts, etc.  For instance, you can take your ruby app, add some rake tasks as well as config management scripts to allow people to deploy and manage your app.

## Sharing & Collaboration

Modules can be shared and collaborated on with team members via your Dtk Server and publically shared if published to the Dtk Catalog which is the global Service Catalog for Dtk users.


## Versioning

By default when a module is created it just has its "master" version, corresponding to the master git branch.  As changes are made and you wish to publish specific working versions for others to leverage you simple run:

{% highlight bash linenos %}
//TODO: put versioning commands here

~/dtk-modules/foo-module$ dtk version 1.2.3
{% endhighlight %}

Its that simple.  Anyone with a dependency on your `foo-module` Module will now get the latest when they install/update their dependencies.  More details on versioning and dependencies can be found in the "Publishing & Sharing Dtk Modules" section.


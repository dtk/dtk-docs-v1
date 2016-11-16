---
title: Versioning
order: 1
---

# Dtk Module Versioning

By default when a module is created it just has its "master" version, corresponding to the master git branch.  As changes are made and you wish to publish specific working versions for others to leverage you simple run:

{% highlight bash linenos %}
//TODO: put versioning commands here

~/dtk-modules/foo-module$ dtk version 1.2.3
{% endhighlight %}

Its that simple.  Anyone with a dependency on your `foo-module` Module will now get the latest when they install/update their dependencies.  More details on versioning and dependencies can be found in the "Publishing & Sharing Dtk Modules" section.


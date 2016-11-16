---
title: Dkt Modules
permalink: modules/index
---

# Dtk Modules

Dtk Modules handle dependency management and act as the base unit for Dtk developers to version and share via a source controlled backed Service Catalog.  Modules allow Dtk users to bundle up related configuration, deployment and application files and logic into a manageable, versioned unit.  This serves to closely connect deployment logic and management scripts with the actual code getting deployed and managed.

Dtk Modules are analogous to npm modules in Node.js or gems in Ruby with one major difference in that a Dtk Module can include Components and assets of any language type, including "mixed Modules" that include multiple types of languages in one, such as Ruby, Python, Node.js, Bash scripts, puppet manifests, etc.  For instance, you can take your Ruby app, add some shell scripts and/or Rake tasks as well as config management scripts to allow people to deploy and manage your app in a self-contained manner.


## Module Definition Model

Modules are source controlled directories defined by a simple "wrapper" DSL, which provides something akin to an object oriented interface that hides the implementation details of the actual code, script, manifests, etc.  This enables the Dtk to expose deployment and management workflows in a language agnostic way that hide the fact that the actual code behind the implementation can vary from step to step.

Each Module must contain, and is defined by its Module DSL defintiion file **dtk.module.yaml**.  With the Dtk's mantra of allowing the highest level of asset reuse possible, Module content can be placed anywhere in its directory structure, which greatly helps with importing existing projects and repos to make them "Dtk enabled".

Lets look at an example of a partial Module definition file:

{% highlight bash linenos %}
---
module: aws/rds
version: 0.2.0
keywords: aws, rds
description: For deploying rds databases
license: Apache 2.0
  
depdenecies:
- ruby/rubygems: 0.1.1
assemblies:
  mysql:
    description: Mysql db
    components:
      rds::mysql
        attributes:
          ...
    workflows:
      create:
        subtasks:
        - name: mysql db
          components:
          - rds::mysql
  ...
components:
  mysql:
    attributes:
    ...
    actions:
      create:
        ...
      delete
        ...
  postgres:
   attributes:
    ...
   actions:
      create:
        ...
      delete
        ...
  
  ...
{% endhighlight %}

The first section contains the base properties defining the Module and typically define things such as name, version and various optional metadata to make sharing, discovery and reuse easier.  A current list of base properties are:

| Property | Description | Required |
|----------|:------------|:--------:|
| module   | Unique name for the module | X |
| version  | Current defined/in-use version | X |
| keywords | Metadata keywords for search/discovery | |
| description | Description for others to understand what the module is about | |
| license  | Applied license, if any, for the module | |
{: .table .table-bordered }

### Module Dependencies
The **dependencies** property in Module definition is similar to that of Component dependencies, but instead denotes that "this module required these modules to be present and installed for proper usage".  This is similar to linux package dependencies, or how dependencies are defined in a package.json file for Node.js or gemfile for Ruby apps.

### Module DSL Objects

Besides its base properties and dependencies, Modules can contain any number of the following defined DSL objects:

 * **[Components](/{{ site.siteBaseDir }}components):** Your building blocks representing your various Service and Infrastructure resources
 * **[Assemblies](/{{ site.siteBaseDir }}assemblies):** Various topologies and Service definitions to be deployed

Please see each DSL objects corresponding doc content to learn more details and how to use

## Module Installation


The Dtk Catalog makes it easy to get going with Service development without having to start from scratch.  Available for installation are Component and Service Modules.  This section will take you through installing various Modules that will be used in later learning examples.  Start by logging into your Dtk Client.

To display a list of Component Modules in the Community Catalog run the following Dtk Client Command:

{% highlight bash linenos %}
dtk:/component-module>ls --remote
+-------------------------+---------------------+
| NAME                    | LAST UPDATED        |
+-------------------------+---------------------+
| bigtop/bigtop_base      | 2014/03/18 03:18:33 |
| bigtop/hadoop           | 2014/03/22 02:46:18 |
| bigtop/hadoop_zookeeper | 2014/04/07 18:00:12 |
| kaiyzen/nodejs             | 2014/05/05 08:12:16 |
| puppetlabs/concat       | 2014/04/24 00:47:25 |
| puppetlabs/java         | 2014/03/25 23:31:28 |
| puppetlabs/mysql        | 2014/03/26 00:29:27 |
| puppetlabs/stdlib       | 2014/03/25 23:30:32 |
| puppetlabs/sysctl       | 2014/03/25 23:33:52 |
| r8-tests/java           | 2014/04/06 01:06:10 |
| r8-tests/link_def_test  | 2014/03/23 00:41:57 |
| r8/mongodb        | 2014/04/08 00:08:07 |
| r8/remote_ns | 2014/04/02 00:03:41 |
| r8/test           | 2014/04/24 03:18:54 |
| r8/apacheds             | 2014/04/11 00:27:09 |
| r8/base                 | 2014/03/21 00:57:17 |
| r8/host                 | 2014/04/09 03:38:59 |
| r8/java                 | 2014/04/22 17:07:02 |
+-------------------------+---------------------+
18 rows in set
{% endhighlight %}

To install a Module of your choice simply run the *install* command from the component-module context:

{% highlight bash linenos %}
dtk:/component-module>install bigtop/hadoop

module_directory: /root/dtk/component_modules/hadoop
{% endhighlight %}

If you ran the preceeding command you would now have the Apache Foundation Bigtop Component Module available in your DTK Server instance, ready to design and deploy services with


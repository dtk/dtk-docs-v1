---
title: Overview & Installion
order: 1
---

# Overview and How To Install Dtk Modules

## Installation


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

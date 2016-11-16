---
title: Component Links
order: 20
---

## Dtk Component Links

Beng able to express associations between Dtk Components plays a key role in a DTK. When defining a Component in the Dtk DSL, the user can capture Component linkages that then are applicable in any Assembly that they are used in. These linkages are illustarted by the follwing DSL fragment for component 'wordpress::app':
{% highlight bash linenos %}
    attributes:
      db_host:
        type: string
        required: true
      db_port:
        type: integer
        required: true
          .
          .
    dependencies:
      - mysql::server
    link_defs:
      mysql::server:
        attribute_mappings:
        - $node.host_address -> db_host
        - $port -> db_port
{% endhighlight %}

The dependencies section above captures that Component wordpress::app is dependent on Component ‘mysql::server’ being present. Consequently, if the user tries to deploy an Assembly that has wordpress::app, but not mysql::server, then a violation is raised that blocks execution. This dependency is defined to be applicable in a distributed application meaning that it just means that mysql::server Component must be in the Assembly, but not necessary on the same node as wordpress::app.

The link_def section above captures how wordpress::app’s attributes should be synchronized with the attributes of the mysql::server Component it is connecting to. The first attribute mapping
{% highlight bash linenos %}
$node.host_address -> db_host
{% endhighlight %}
captures that host address of the node that mysql::server is placed on is used to set wordpress::app’s db_host attribute. This is a form of service discovery. By capturing this association it allows the Dtk in any environment that wordpress::app is spun up to bind to the host address of mysql::server in the same environment.

The second attribute mapping:
{% highlight bash linenos %}
$port -> db_port
{% endhighlight %}
captures that the value set on mysql::server’s ‘port’ attribute is used to set the ‘db_port’ attribute on wordpress::app. This enables a user to change the port on musql::server to a non standard port and this value will be automatically propagated to wordpress::app.

In the example above wordpress::app was just linked to one dependent component. It is common that a component is linked to multiple components. For wordpress::app, as an example, it could be linked to an nginx component that front ends it.

The Link Def syntax reflects an ETL-like specification to coordinate attributes in related components. Another analogy is that they are like foreign keys in a database. In the example above we just showed the case where the base component (wordpress::app) gets attributes from a Component it is dependent on (mysql::server). The relationship can go the other way, which would be reflected by using in the attribute mapping the symbols ‘<-‘ instead of ‘->’. An example we cover in more detail is connecting wordpress::app to nginx. In this case, nginx must get the host address and port from wordpress as well as any other application it front ends.

In the next sub-sections below we go over the more advanced ways that Link defs can be specified to do things like express that wordpress::app is not dependent on just one specific database (MySQL) but instead can connect to a set of them  (e.g, Postgresql, Orcale and with MySQL)

### Link Defs with alternative choices

TODO: modify and incorporate
This is an ETL-like specification that enables the Dtk user to capture when linking to a MySQL db as an alternative that it must use the attribute on the MySQL that denotes its listening port, but may be named differently than ‘port’.


### LinkDefs connecting to arrays

TODO: give an example with ngix. There can be multiple components that connect to nginx,. Each one splices into an array in nginx thatmaintains the list of host address, ports etc that traffic is routed to

### Link Def without Dependency
 
capture how two related Components Attributes should be coordinated. An example is a Link Def that captures that 'db_host' gets the host address  

### Dependencies that restrict where the Component is placed

TODO: ...

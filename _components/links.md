---
title: Links
order: 20
---

## Dtk Component Links

When deploying and managing Service and Infrastructure Components it is common that they will need to share information with other Components in your deployment(s).  A simple example is where an application Component needs to know the host and port of the database Component in order to establish a connection.  Instead of having to enter Attribute values in multiple locations, or rewrite your Applications and Services to use a specific service discovery solution, the Dtk comes with a built in solution with its Links functionality.
<br/><br/>
Links allow you to be able to express associations between Dtk Components in a simple and concise format.  When defining a Component the user can capture Component linkages that then are applicable and can be re-used in any deployment that they are used in.  The **Link Def** syntax reflects an ETL-like specification to coordinate Attributes across related Components, much like foreign keys across tables in a database.   

Here is a reference example for our simple application to database linkage in the application component definition:
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
<br/>
The **link_def** section above captures how the applications Attributes should be synchronized with the Attributes of the mysql::server Component it is connecting to. The first **attribute_mapping**
{% highlight bash linenos %}
$node.host_address -> db_host
{% endhighlight %}
captures that host address of the node that mysql::server is placed on is used to set wordpress::app’s db_host Attribute.  By capturing this association it allows the Dtk in any environment that wordpress::app is spun up to bind to the host address of mysql::server in the same environment and acts as a form of service discovery without any change to your application or process(es).  In the case of a virtual environment where IP addresses are dynamically assigned, the Dtk would also automatically propagate new IP/host values whenever the node is restarted.

The second **attribute_mapping**:
{% highlight bash linenos %}
$port -> db_port
{% endhighlight %}
captures that the value set on mysql::server’s **port** Attribute is used to set the **db_port** Attribute on the application component.  Should the user choose to change the port on the mysql::server to a non standard port the new configuration value will be automatically propagated to application.

In the example above we showed "uni-directional" passing of Attributes via the Link.  It is common the developer will require to pass Attributes between two linked Components in both directions, which would be reflected by using in the **attribute mapping** syntax the symbols ‘<-‘ instead of ‘->’ to denote the directional flow of the Attribute values when they are set/changed.  Later we will show more advanced examples with "bi-directional" Link Defs and multiple Component dependencies.
<br/>
## Dependencies

The **dependencies** section in the above example captures that the application Component is dependent on the database ‘mysql::server’ Component being present.  Consequently, if the user tries to deploy the application without a mysql::server Component present and linked, then a violation is raised that blocks execution.  This dependency is defined to be applicable in a distributed application meaning that it just means that mysql::server Component must be in the Assembly, but not necessary on the same node as wordpress::app.

### Link Defs with alternative choices

TODO: modify and incorporate
This is an ETL-like specification that enables the Dtk user to capture when linking to a MySQL db as an alternative that it must use the attribute on the MySQL that denotes its listening port, but may be named differently than ‘port’.


### LinkDefs connecting to arrays

TODO: give an example with nginx. There can be multiple components that connect to nginx,. Each one splices into an array in nginx thatmaintains the list of host address, ports etc that traffic is routed to


### Handling fully meshed component connections

TOOD: explain how we model things like quoroms

### Link Def without Dependency
 
capture how two related Components Attributes should be coordinated. An example is a Link Def that captures that 'db_host' gets the host address  

### Dependencies that restrict where the Component is placed

TODO: ...

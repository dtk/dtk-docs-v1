---
title: Actions
order: 20
---

# Component Actions

Associated with each Dtk Component is one of more Actions that perform operations such as deployment, configuration, deleting resources, querying state, testing or performing maintenance. The Dtk DSL provides an interface in the Objected Oriented sense for the actual code or scripts, i.e., Puppet, Bash, Puppet). An example of a DSL fragment capturing Actions for a Component ‘hadoop::namenode’ is as follows:

{% highlight bash linenos %}
{% raw %}
    attributes:
      port:
        type: port
        dynamic: true
      http_port:
        type: port
        dynamic: true
      hdfs_daemon_user:
        type: string
        dynamic: true
    actions:
      create:
        puppet_class: hadoop::namenode
      smoke_test:
        commands:
        - RUN echo "namenode port={{port}}"
        - RUN netstat -nltp | grep {{port}}
        - RUN su {{hdfs_daemon_user}} -c "hdfs dfsadmin -safemode get" | grep OFF
      leave_safemode:
        command:
          RUN su {{hdfs_daemon_user}} -c 'hdfs dfsadmin -safemode leave'
{% endraw %}
{% endhighlight %}

In this example there are three types of actions. The Action ‘create’ when executed on a node installs the Hadoop Namenode daemon, configures it and starts the service. The action ‘smoketest’ is a test that would be run in a worflow after the create Action is done to make sure that the service is actually up. If its results indicate failure it will stop the workflow from processing. The third Action ‘leave_safemode’ is a maintenance operation applicable to Hadoop Namenodes.

Under each Action are fields that indicate the code or script that is doing the actual steps and related parameters. In this case the action ‘create’ is being implemented by Puppet and the actions ‘smoketest and ‘leave_safemode’ using Bash. The “Language Provider” types ‘puppet’ and ‘bash’ dont need to be specifically given since they can be inferred from the fields under Action.

The typical pattern for actions is shown by
{% highlight bash linenos %}
    create:
        puppet_class: hadoop::namenode
{% endhighlight %} 

In this case the assignment ‘puppet_class: hadoop::namenode’ indicates the top level Puppet Class to call when action ‘create’ is calle. For Puppet, the other alternative is identifying a top level Puppet Definition to call. Behind these top level Puppet Class or definition is a full Puppet module that can be arbitrarily nested. These top level Classes and Definitions will typically call Puppet Classes, Definitions, Resources, and Functions that would be in the nested in the module

The Bash Actions are atypical in that the DSL itself has the code inline to the DSL, ‘i.e., Bash commands to run

The subsection ‘Language Providers’ describes the currently supported languages that the Action Implementations can be written in (Bash, Puppet, and Ruby) as well as how the set of Language providers can be extended

### Action Invocation Parameters

When any action is executed it has access to all the attributes that are set on the Component as input much the same way in Object Oriented languages method calls have access to an object's state variables. The mechanism to map between Dtk attributes differs from Language Provide to Language Provider. For Puppet the convention is used that the Dtk Attribute names correspond one to one with the names used in the signatire for corresponding top level Puppet Classes and Definitions.

For Bash Language provider Dtk attributes are passed in through use of Mustache template variables.

### Create (Converge) actions
Each Dtk component must have a 'create' Action defined. The user has the flexibility to define a Create action in different ways such as
* an action that creates a new resource
* an action that discovers an existing resource
* an action that just 'stages' the component that then can be actually deployed by following up with another action on the component that does the actual deployment

A typical pattern is to have the create action encode ‘idempotent’ semantics, meaning that once created, the create action can be run again after changing the component’s attributes. This subsequent create call will try to bring the actual resource to the desired state reflected in the attribute settings. Consequently, we will sometimes refer to the create Action as a ‘converge’ Action since it tries to “converge to a state”. The Dtk user has flexibility to define the create Action so it only works when creating the resource from scratch or only works for certain attribute changes, raising errors if changes are made that are not supported.

## Delete Actions

Delete actions are optional. If the user defines a delete action then this is executed when the user deletes the component from the deployment environment. Sometimes a delete action is not necessary, such as components that get installed on nodes. If the node itself is deleted there may be no need to delete the components inside the component. Conversely when provisioning cloud services it is typically important to destroy the resources that are created when decommissioning the deployment.

## Component-Specific Actions

The Dtk user has flexibility to also define other types of actions to things such as
* return information about component's actual state
* action that performs a test and returns the results, such as use of smoke tests interspersed in a workflow that can abort execution upon failure
* actions that copy or backup datasets

TODO: add more detail

### Mechanism for Action Implementations to pass back attribute values

TODO: explain the general pattern taht is used in each Langigae provider that enables teh code to pass values back to the Dtk

### Action with method parameters

TODO: explain: Much in the same way that in an Object Oriented language instance methods can use explicit parameters passed in the method call as well as the object's state variables, the same can be done with Dtk. However, it is encouraged that Component Attributes be used when they can for a number of reasons.... Explicit methods are useful to indicate how the action is performed in contrast to what they should do.

### Actions to handle more complex Attribute relationships

TODO: give examples and explain that a special type of action can be used that is executed in a secure sandbox on the Dtk server and is used when one needs the power of a programming language (Ruby) to compute an attribute value in terms of other values

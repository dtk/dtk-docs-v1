---
title: Workflows
order: 1
previous_page:
  url: /assemblies
next_page:
  url: /modules
---

# Assembly Workflows

Each Assembly has one or more Workflows, each of which specifies the order in which Component Actions are executed to achieve actions “at the Assembly level”, i.e. actions that bring up a whole stack, bring it down or make changes at the service level that coordinate across the possibly distributed Components. Each Assembly will have a create/converge Workflow, a delete Workflow, and can have Assembly-specific workflows defined that vary from stack to stack. The create and delete Workflows can be explicitly specified by the user. Alternatively, the user can leverage the Dtk’s ability to automatically generate these workflows from an Assembly and use them as is or customize them to, for example, put in smoketests or gain more concurrency.

Consider the example wordpress Assembly:
{% highlight bash linenos %}
   nodes:
      wordpress:
        components:
        - nginx::server
        - wordpress::nginx_config
        - wordpress::app
        - mysql::server
{% endhighlight %} 

An example create Workflow can look like
{% highlight bash linenos %}
    create:
        subtask_order: sequential
        subtasks:
        - name: mysql install
          ordered_components:
          - mysql::server
        - name: nginx install
          ordered_components:
          - wordpress::nginx_config
          - nginx::server
        - name: wordpress install
          ordered_components:
          - wordpress::app
{% endhighlight %} 
This workflow specifies a set of sequential steps that are organized into stages. As the Workflow is executed, the stages are displayed to provide context where in the execution the system is at.

The base steps in the Workflow are Component references, each of which must correspond to a Component in the Assembly. (Note: The order of components in an Assembly does not impact the order of execution; just the Workflow does). In this example, the base steps are of form:

{% raw %}
MODULE-NAME::COMPONENT-NAME
{% endraw %}
They can also have form
{% raw %}
MODULE-NAME::COMPONENT-NAME.ACTION-NAME
{% endraw %}
where the term ACTION-NAME is an action defined on the Component. By convention if ACTION-NAME is omitted it means to use the Component’s create/converge Action.

A unique feature of a Dtk Workflow is that the Assembly sets the context for the Workflow. First, there is no description in Workflows about how attributes on Components are set and passed from one step to the next. Section ‘Workflows and Component Links’ describes how the Component Links take care of Attribute coordination automatically. This enables workflows to be succinct and concentrate on Action ordering.

Second, Workflow steps can be written without mentioning nodes. The semantics for a step like
{% highlight bash linenos %}
- name: mysql install
   ordered_components:
    - mysql::server
{% endhighlight %}
means to execute the create/converge action on all nodes that mysql::server is on as captured by the Assembly. This allows the use of the same Workflow for different topological variants of an Assembly, which covers cases such as a single node deployment and possibly varying multi node deployments

TODO: flesh out

### The create/converge Workflow

### The delete Workflow 

### Workflows and Component Links

### Multi Node Workflows and Node Groups

### Temporal ordering with nested sequential and concurrent blocks

### Intermixing deployment Actions and smoketest Actions

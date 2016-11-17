---
title: Workflows
order: 1
---

# Assembly Workflows

Each Assembly has one or more Workflows, each of which specifies the order in which Component Actions are executed to achieve actions “at the Assembly level”, i.e. actions that bring up a whole stack, bring it down or make changes at the service level that are coordinated across the pieces. Each Assembly will have a create/converge Workflow, a delete Workflow, and can have Assembly specific workflows defined that vary from stack to stack. The create and delete Workflows for an Assembly can be explicitly given or instead the user can leverage the DTk’s ability to generate a workflow that the end user can use as is or customize to for example put in smoketests or gain more concurrency.

Conisder the example wordpress Assembly:
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
This workflow specifies a set of sequential steps that are organized into stages. As the workflow is executed, the stages are displayed to provide context where in the execution the system is at.

The base steps in the Workflow are Component references, each of which must correspond to a Component in the Assembly. (Note: The order of components in an Assembly does not impact the order of execution, just the Workflow does). In this example, the base steps are of form:

{% raw %}
MODULE-NAME::COMPONENT-NAME
{% endraw %}
They can also have form
{% raw %}
MODULE-NAME::COMPONENT-NAME.ACTION-NAME
{% endraw %}
where the term ACTION-NAME is an action defined on the Component. By convention if ACTION-NAME is omitted it means to use teh Compent's create/converge Action.

A unique feature of a Dtk Workflow is that the Assembly sets the context for the Workflow, which allows a very succinct and possibility to use same Workflow for different assemblies. First, there is no description in Workflows about how attributes on Components are set and passed from one step to the next. Section ‘Workflows and Component Links’ describes how the Component Link Defs take care of the Attribute coordination automatically. Second, Workflows, like this one exhibits, can be written without mentioning nodes. The semantics for a step like
{% highlight bash linenos %}
- name: mysql install
   ordered_components:
    - mysql::server
{% endhighlight %}
is that it means to execute the create/converge action for all nodes that mysql::server is on. Consequenely the same workflow could be potentially used regardless whether wordpress is on the same or different node than mysql.

TODO: flesh out

### The create/converge Workflow

### The delete Workflow 

### Temporal ordering with Sequential and Concurrent blcoks

### How Assembly automatically handles paramter passing in workflow

### Workflows with Node Groups

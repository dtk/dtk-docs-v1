---
title: Dtk Assemblies
permalink: assemblies/index
---

## Dtk Assemblies

A Dtk assembly encodes the desired state to achieve when deploying a single component or a set of interrelated components making up possibly a complex distributed application or service. 

TODO: give some examples of assemblies.

An assemebly is written in the Dtk DSL that has syntax to capture
* Assembly structure - the set of components that make up the deployment and where each component is deployed, the choices being on an Internet service or nodes that can be cloud instances, a virtual or physical machines.
* Deployment-specific settings - which refer to attribute settings that override the defaults and links between components in the assembly as well as links to components in other deployed assemblies providing needed services or context 
* Workflows - which are used to create and destroy the deployment captured by the assembly and perform any assembly-specfic actions that the Dtk assembly author provided


### Dtk Assembly DSL

The top level DSL structure for an assembly is given by

{% highlight bash linenos %}
components:
  <component_ref>
       .
       .
  <component_ref>
nodes:
  <node_with_component_refs>
      .
      .
  <node_with_component_refs>      
workflows:
   <workflow>
      .
      .
   <workflow>

-----
where <component_ref> has form
  <component_name>
  -- OR --
  <component_name>:
    attributes:
      <attribute_setting>
           .
           .
      <attribute_setting>
    component_links:
      <component_link>
           .
           .
      <component_link>

and <node_with_component_refs> has form
  <node_or_node_group_name>:
    attributes:
      <node_attribute_setting>
            .
            .
      <node_attribute_setting>
    components:
      <component_ref>
            .
            .
      <component_ref>
{% endhighlight %}

The Assembly subsections go into detail on each of these DSL parts


# Move to a section we use for 'DTK user workflows around creating service instances'

A Dtk module can contain one or more assemblies, which are sometimes referred to as 'assembly templates' because they serve as reusable deployment templates, each of which can be deployed multiple times in different environments. 

When an assembly template is 'staged'  -- meaning instantiated, but not yet deployed    -- a dedicated service instance is created having an instantiated version of the assembly template, which we will sometimes refer to as an 'assembly instance'.  In section (?ref) we detail the difference between an assembly template and assembly instance. They both have the same DSL syntax; the main difference is that an assembly instance can have more detail than its parent template. This added detail is automatically and/or manually filled in that provides deployment-specific parameters and deployment-specific connections to other components in the selected deployment environment. Additionally the instance can have automatically generated workflows.


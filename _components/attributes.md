---
title: Attributes
order: 10
---

# Component Attributes

A Component's Attributes capture its desired, configured, or actual state. When an Action is executed on a Dtk Component the Action has access to the attribute settings much in the same way that methods in an Object Oriented language have access to the object's instance variables. Actions can use these attribute settings as inputs, as outputs or as values that can be updated during execution. A common case where outputs are used is when an Action is doing discovery and returning back info about the actual resource that corresponds to the Dtk Component.

In the DTK Component DSL each attribute is described using the following fields, some of which just are optional to include
* default - optional field that provides an Attribute's default value
* description - optional text description of the attribute
* dynamic - optional Boolean field that is 'false' by omission. If this is set to true then it means that during execution of the Component's create action this value will be dynmically computed. i.e., it is an output attribute.
* hidden - optional Boolean field that is 'false' by omission. If this field is set to 'true' then its value is hidden when displaying values in the DTk
* input - optional Boolean field that is 'false' by omission. This field is used when 'dynamic' is set to true to mean that the value also services as an input value that can be updated upon Action execution.
* required - optional Boolean field that is 'false' by omission. If this field is set to true it means that this value must be set before an Action on this Component is executed
* type - datatype of the Attribute's value; currently supported datatypes are 'string', 'integer', 'boolean', 'hash', 'array’



A Component's Attributes are given in the Dtk DSL under the Component's attribute section, such as
{% highlight bash linenos %}
 vpc:
    attributes:
      name:
        description: DTK name
        type: string
        required: true
      vpc_id:
        description: AWS VPC id
        type: string
      region:
        description: AWS region
        type: string
        required: true
      aws_access_key_id:
        type: string
        hidden: true
      aws_secret_access_key:
        type: string
        hidden: true
      images:
        type: hash
        dynamic: true
        hidden: true
{% endhighlight %}





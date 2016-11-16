---
title: Attributes
order: 10
---

# Component Attributes

A Component's Attributes capture the desired, configured, or actual state. When an Action is executed on a Dtk Component the Action has access to the Attribute settings much in the same way that methods in an Object Oriented language have access to the object's instance variables. Actions can use these attribute settings as inputs, as outputs or as values that can be updated during execution. A common case where outputs are used is when an Action is doing discovery and returning back info about the actual resource that corresponds to the Dtk Component.

A Component's Attributes are given in the Dtk DSL under the Component's Attribute section, such as:

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

Attributes can contain the following properties

| Property      | Description                                                                   | Required  | Valid Values |
|:-------------:|:------------------------------------------------------------------------------|:---------:| ------------ |
| type          | Datatype of the Attribute                                                     |     X     | ('string', 'integer', 'boolean', 'hash', 'array’) | 
| default       | Provides an Attribute's default value                                         |           | any          |
| required      | If true, value must be set before executing any Action, 'false' by default    |           | true or false  |
| description   | Text description of the attribute                                             |           | true or  false |
| dynamic       | If 'true' sytem computes value (see [Dynamic Attributes](#dynamic-attributes) for more details), 'false' by default if omitted |           | true or false |
| hidden        | If 'true' the Attributes value is hidden when displaying values in the Dtk, 'false' by default if omitted |           | true or false |
| input         | (see [Dynamic Attributes](#dynamic-attributes) for more details) 'false' by default if omittied      |           | true or false |
{: .table .table-bordered }

## <a name="dynamic-attributes"></a>Dynamic Attributes

If this is set to true then it means that during execution of the Component's create action this value will be dynmically computed. i.e., it is an output attribute.

input - This field is used when 'dynamic' is set to true to mean that the value also services as an input value that can be updated upon Action execution.
TODO: more here

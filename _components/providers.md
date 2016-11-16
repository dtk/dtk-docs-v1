---
title: Language Providers
order: 30
---

# Component Language Providers

TODO: fill in the sections below 

## Currently Supported Providers

### Puppet
Note: bring in points
* Puppet Action fields Top level Classes and Definitions will typically call Puppet Classes, Definitions, Resources, and Functions that would be in the module
* How to insure that dependent modules are installed so they can be referenced like functions from Puppet stdlib module
* Use of built in Puppet definition ‘export_variable to enable Puppet code to send back computed attribute values to the Dtk 

### Bash
Note: bring in:
* Bash Action fields
* How stdout and stderr used

### Ruby

Note: bring in:
* Ruby Action fields: Ruby entry point
* Ruby method to send back Dtk dynamic attributes

## Runtime environment
Notes: indicate how internal Dtk containers used to set runtime context like for Ruby making sure proper version Ruby interpreter is installed as well as needed Gems and any OS packages for native gems


## Adding a new Language Provider
Note: bring:
* Use of Grpc and wrapper code to get attribute values and other data back and force between code and Dtk environment 
* interface and conventions in writing a new Language Provider
* How code in one module can use code in another module















Note: bring in points
* Puppet Action fields
Top level Classes and Definitions will typically call Puppet Classes, Definitions, Resources, and Functions that would be in the module
* How to insure that dependent modules are insatlled so they can be refernced like functions form Puppet stdlib module
* Use of publcially supplied export_varibale Definition so that Dtk dynmaic attributes can be set 

### Bash

Note: bring in:
* Bash Action fields
* How stdout and stderr used
### Ruby

Note: bring in:
* Ruby Action fields: Ruby entry point
* Ruby method to send back Dtk dynmaic attributes

## Runtime environment

Notes: indicate how internal Dtk containrs used to set runtime context like for Ruby making sure Ruby interprter is installed as well as needed Gems and any OS packages for native gems   

## Adding a new Language Provider

Note: bring:
* grpc wrapper for each language
* interface and conventions in writing a new Langugae Provider






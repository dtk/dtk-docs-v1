---
title: Component Links
order: 20
---

## Dtk Component Links

Go over the DSL dependency and link def section

# TODO: olde text; see what can use

A key feature of the Dtk is that a component can be given dependencies, such as one that says an app component requires a db component. By associating the dependencies with a reusable component, these dependencies get inherited by the environments in which they leave. This enables the Dtk to both raise violations when dependencies are missing as well as when possible to ‘auto complete’ dependencies, such as automatically binding a component to a database in an environment where it is deployed. This is a form of service discovery. In the Dtk DSL there are two constructs that pertain to component dependencies:
* A dependency that says that a component requires another component ort a choice between components (e.g., an app may require a Postgresql, MySQL, Oracle database server)
* ‘Link defs’ which capture when a component has a dependency on another one how their attributes should be synched. An example is a link def that captures that ‘db_port’ on the app component gets its value from attribute ‘port’ on a Postgresql component. This is an ETL-like specification that enables the Dtk user to capture when linking to a MySQL db as an alternative that it must use the attribute on the MySQL that denotes its listening port, but may be named differently than ‘port’.




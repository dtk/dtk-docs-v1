---
title: Dtk Assemblies
permalink: assemblies/index
---

## Dtk Assemblies

A Dtk assembly encodes the desired state to achieve when deploying a single component or a set of interrelated components making up possibly a complex distributed application or service. A Dtk module can contain one or more assemblies, which are sometimes referred to as 'assembly templates' because they serve as reusable deployment templates, each of which can be deployed multiple times in different environments. 

When an assembly template is 'staged'  -- meaning instantiated, but not yet deployed    -- a dedicated service instance is created having an instantiated version of the assembly template, which we will sometimes refer to as an 'assembly instance'.  In section (?ref) we detail the difference between an assembly template and assembly instance. They both have the same DSL syntax; the main difference is that an assembly instance can have more detail than its parent template. This added detail is automatically and/or manually filled in that provides deployment-specific parameters and deployment-specific connections to other components in the selected deployment environment. Additionally the instance can have automatically generated workflows.

## Base assembly constructs

Associated with an assembly can be zero or more 'workflows' ...

The internals of an assembly has ... components, nodes etc

Todo: next start going over sections with DSL snippets


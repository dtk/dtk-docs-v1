---
title: Dtk User Workflows
order: 5
---

# Dtk User workflows

TODO: flesh out these notes

There are two basic workflows:
* one for a DTK user that is deploying applications and software
* one for a DTK user that is building the 'Assemblies' and Components' that go in aservice catalog and get used by the user making deployments. We wil sometimes refer to this user as a 'Dtk author'

These workflows can be intermixed for example, a Dtk author would increemtally build out components and assemblies using teh deplymentcapability to inremntally test. In section (??) we show that teh Dtk provides capabiliitioes that allow a DTk author to work in sandbox to make local changes to test before promoting the changes to the catalog

Note: might mention that a depelyment user could also customize by ....

## Workflow for deployment


Note: mention that the getting started example is a 'deployment workflow'

Note: cut and paste from section taht was under asemblies


A Dtk module can contain one or more assemblies, which are sometimes referred to as 'assembly templates' because they serve as reusable deployment templates, each of which can be deployed multiple times in different environments. 

When an assembly template is 'staged'  -- meaning instantiated, but not yet deployed    -- a dedicated service instance is created having an instantiated version of the assembly template, which we will sometimes refer to as an 'assembly instance'.  In section (?ref) we detail the difference between an assembly template and assembly instance. They both have the same DSL syntax; the main difference is that an assembly instance can have more detail than its parent template. This added detail is automatically and/or manually filled in that provides deployment-specific parameters and deployment-specific connections to other components in the selected deployment environment. Additionally the instance can have automatically generated workflows.


## Workflow for Dtk authors
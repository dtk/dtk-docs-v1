---
title: Attributes
order: 10
---

# Component Attributes

A component’s attributes typically represent desired or configured state to achieve when the component is created. When any action is executed it has access to all the attributes that are set on the component as input much the same way in OO languages method calls have access to an objects state variables. A Dtk action can also set component attributes after execution. This is the mechanism that the Dtk uses for discovery. As an example a workflow can first have a AWS vpc component that discovers the relevant AWS vpc id, which can be feed to a subsequently executed vpc subnet component that creates a vpc subnet and needs its parent’s id. 





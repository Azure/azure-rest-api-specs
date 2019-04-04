# Multi-API support for AutoRest v3 generators

> see https://aka.ms/autorest

``` yaml $(enable-multi-api)
input-file:
  - Microsoft.Features/stable/2015-12-01/features.json
  - Microsoft.Authorization/stable/2016-09-01/locks.json
  - Microsoft.Authorization/stable/2015-01-01/locks.json
  - Microsoft.Authorization/stable/2018-05-01/policyAssignments.json
  - Microsoft.Authorization/stable/2018-05-01/policyDefinitions.json
  - Microsoft.Authorization/stable/2018-05-01/policySetDefinitions.json
  - Microsoft.Authorization/stable/2018-03-01/policyAssignments.json
  - Microsoft.Authorization/stable/2018-03-01/policyDefinitions.json
  - Microsoft.Authorization/stable/2018-03-01/policySetDefinitions.json
  - Microsoft.Authorization/preview/2017-06-01-preview/policyAssignments.json
  - Microsoft.Authorization/preview/2017-06-01-preview/policySetDefinitions.json
  - Microsoft.Authorization/stable/2016-12-01/policyDefinitions.json
  - Microsoft.Authorization/stable/2016-12-01/policyAssignments.json
  - Microsoft.Authorization/stable/2016-04-01/policy.json
  - Microsoft.Authorization/preview/2015-10-01-preview/policy.json
  - Microsoft.Resources/stable/2018-05-01/resources.json
  - Microsoft.Resources/stable/2018-02-01/resources.json
  - Microsoft.Resources/stable/2017-05-10/resources.json
  - Microsoft.Resources/stable/2016-09-01/resources.json
  - Microsoft.Resources/stable/2016-07-01/resources.json
  - Microsoft.Resources/stable/2016-02-01/resources.json
  - Microsoft.Resources/stable/2015-11-01/resources.json
  - Microsoft.Resources/stable/2016-06-01/subscriptions.json
  - Microsoft.Resources/stable/2015-11-01/subscriptions.json
  - Microsoft.Resources/stable/2016-09-01/links.json
  - Microsoft.Solutions/stable/2018-06-01/managedapplications.json
  - Microsoft.Solutions/stable/2017-09-01/managedapplications.json
  - Microsoft.Solutions/preview/2016-09-01-preview/managedapplications.json
require: ../../../../profiles/readme.md
```

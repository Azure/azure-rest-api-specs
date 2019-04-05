# Multi-API support for AutoRest v3 generators

> see https://aka.ms/autorest

``` yaml $(enable-multi-api)
input-file:
  - $(this-folder)/Microsoft.Features/stable/2015-12-01/features.json
  - $(this-folder)/Microsoft.Authorization/stable/2016-09-01/locks.json
  - $(this-folder)/Microsoft.Authorization/stable/2015-01-01/locks.json
  - $(this-folder)/Microsoft.Authorization/stable/2018-05-01/policyAssignments.json
  - $(this-folder)/Microsoft.Authorization/stable/2018-05-01/policyDefinitions.json
  - $(this-folder)/Microsoft.Authorization/stable/2018-05-01/policySetDefinitions.json
  - $(this-folder)/Microsoft.Authorization/stable/2018-03-01/policyAssignments.json
  - $(this-folder)/Microsoft.Authorization/stable/2018-03-01/policyDefinitions.json
  - $(this-folder)/Microsoft.Authorization/stable/2018-03-01/policySetDefinitions.json
  - $(this-folder)/Microsoft.Authorization/preview/2017-06-01-preview/policyAssignments.json
  - $(this-folder)/Microsoft.Authorization/preview/2017-06-01-preview/policySetDefinitions.json
  - $(this-folder)/Microsoft.Authorization/stable/2016-12-01/policyDefinitions.json
  - $(this-folder)/Microsoft.Authorization/stable/2016-12-01/policyAssignments.json
  - $(this-folder)/Microsoft.Authorization/stable/2016-04-01/policy.json
  - $(this-folder)/Microsoft.Authorization/preview/2015-10-01-preview/policy.json
  - $(this-folder)/Microsoft.Resources/stable/2018-05-01/resources.json
  - $(this-folder)/Microsoft.Resources/stable/2018-02-01/resources.json
  - $(this-folder)/Microsoft.Resources/stable/2017-05-10/resources.json
  - $(this-folder)/Microsoft.Resources/stable/2016-09-01/resources.json
  - $(this-folder)/Microsoft.Resources/stable/2016-07-01/resources.json
  - $(this-folder)/Microsoft.Resources/stable/2016-02-01/resources.json
  - $(this-folder)/Microsoft.Resources/stable/2015-11-01/resources.json
  - $(this-folder)/Microsoft.Resources/stable/2016-06-01/subscriptions.json
  - $(this-folder)/Microsoft.Resources/stable/2015-11-01/subscriptions.json
  - $(this-folder)/Microsoft.Resources/stable/2016-09-01/links.json
  - $(this-folder)/Microsoft.Solutions/stable/2018-06-01/managedapplications.json
  - $(this-folder)/Microsoft.Solutions/stable/2017-09-01/managedapplications.json
  - $(this-folder)/Microsoft.Solutions/preview/2016-09-01-preview/managedapplications.json
require: $(this-folder)/../../../../profiles/readme.md
```

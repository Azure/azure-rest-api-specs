# Multi-API support for AutoRest v3 generators

> see https://aka.ms/autorest

``` yaml $(enable-multi-api)
input-file:
  - $(this-folder)/Microsoft.PolicyInsights/preview/2018-07-01-preview/policyTrackedResources.json
  - $(this-folder)/Microsoft.PolicyInsights/preview/2018-07-01-preview/remediations.json
  - $(this-folder)/Microsoft.PolicyInsights/stable/2018-04-04/policyEvents.json
  - $(this-folder)/Microsoft.PolicyInsights/preview/2018-07-01-preview/policyStates.json
  - $(this-folder)/Microsoft.PolicyInsights/stable/2018-04-04/policyStates.json
  - $(this-folder)/Microsoft.PolicyInsights/preview/2017-12-12-preview/policyEvents.json
  - $(this-folder)/Microsoft.PolicyInsights/preview/2017-12-12-preview/policyStates.json
  - $(this-folder)/Microsoft.PolicyInsights/preview/2017-10-17-preview/policyEvents.json
  - $(this-folder)/Microsoft.PolicyInsights/preview/2017-10-17-preview/policyStates.json
  - $(this-folder)/Microsoft.PolicyInsights/preview/2017-08-09-preview/policyEvents.json
  - $(this-folder)/Microsoft.PolicyInsights/preview/2017-08-09-preview/policyStates.json
require: $(this-folder)/../../../../profiles/readme.md
```

## AzureResourceSchema

These settings apply only when `--azureresourceschema` is specified on the command line.

### AzureResourceSchema multi-api

``` yaml $(azureresourceschema) && $(multiapi)
# include the azure profile definitions from the standard location
require: ../../../profiles/readme.md

output-folder: $(azureresourceschema-folder)/schemas

# all the input files across all versions
input-file:
  - Microsoft.PolicyInsights/preview/2018-07-01-preview/policyTrackedResources.json
  - Microsoft.PolicyInsights/stable/2019-07-01/remediations.json
  - Microsoft.PolicyInsights/stable/2019-10-01/policyEvents.json
  - Microsoft.PolicyInsights/stable/2019-10-01/policyStates.json
  - Microsoft.PolicyInsights/stable/2019-10-01/policyMetadata.json
  - Microsoft.PolicyInsights/preview/2018-07-01-preview/remediations.json
  - Microsoft.PolicyInsights/preview/2018-07-01-preview/policyEvents.json
  - Microsoft.PolicyInsights/preview/2018-07-01-preview/policyStates.json
  - Microsoft.PolicyInsights/stable/2018-04-04/policyEvents.json
  - Microsoft.PolicyInsights/stable/2018-04-04/policyStates.json

```
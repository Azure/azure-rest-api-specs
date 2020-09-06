## AzureResourceSchema

These settings apply only when `--azureresourceschema` is specified on the command line.

### AzureResourceSchema multi-api

``` yaml $(azureresourceschema) && $(multiapi)
batch:
  - tag: schema-policyinsights-2019-10-01
  - tag: schema-policyinsights-2019-07-01
  - tag: schema-policyinsights-2018-07-01-preview
  - tag: schema-policyinsights-2018-04-04

```

Please also specify `--azureresourceschema-folder=<path to the root directory of your azure-resource-manager-schemas clone>`.

### Tag: schema-policyinsights-2019-10-01 and azureresourceschema

``` yaml $(tag) == 'schema-policyinsights-2019-10-01' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.PolicyInsights/stable/2019-10-01/policyEvents.json
  - Microsoft.PolicyInsights/stable/2019-10-01/policyStates.json
  - Microsoft.PolicyInsights/stable/2019-10-01/policyMetadata.json

```

### Tag: schema-policyinsights-2019-07-01 and azureresourceschema

``` yaml $(tag) == 'schema-policyinsights-2019-07-01' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.PolicyInsights/stable/2019-07-01/remediations.json

```

### Tag: schema-policyinsights-2018-07-01-preview and azureresourceschema

``` yaml $(tag) == 'schema-policyinsights-2018-07-01-preview' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.PolicyInsights/preview/2018-07-01-preview/policyTrackedResources.json
  - Microsoft.PolicyInsights/preview/2018-07-01-preview/remediations.json
  - Microsoft.PolicyInsights/preview/2018-07-01-preview/policyEvents.json
  - Microsoft.PolicyInsights/preview/2018-07-01-preview/policyStates.json

```

### Tag: schema-policyinsights-2018-04-04 and azureresourceschema

``` yaml $(tag) == 'schema-policyinsights-2018-04-04' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.PolicyInsights/stable/2018-04-04/policyEvents.json
  - Microsoft.PolicyInsights/stable/2018-04-04/policyStates.json

```

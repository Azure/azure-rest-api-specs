## AzureResourceSchema

These settings apply only when `--azureresourceschema` is specified on the command line.

### AzureResourceSchema multi-api

``` yaml $(azureresourceschema) && $(multiapi)
batch:
  - tag: schema-customerinsights-2017-04-26
  - tag: schema-customerinsights-2017-01-01

```

Please also specify `--azureresourceschema-folder=<path to the root directory of your azure-resource-manager-schemas clone>`.

### Tag: schema-customerinsights-2017-04-26 and azureresourceschema

``` yaml $(tag) == 'schema-customerinsights-2017-04-26' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.CustomerInsights/stable/2017-04-26/customer-insights.json

```

### Tag: schema-customerinsights-2017-01-01 and azureresourceschema

``` yaml $(tag) == 'schema-customerinsights-2017-01-01' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.CustomerInsights/stable/2017-01-01/customer-insights.json

```

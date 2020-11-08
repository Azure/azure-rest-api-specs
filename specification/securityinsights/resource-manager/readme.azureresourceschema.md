## AzureResourceSchema

These settings apply only when `--azureresourceschema` is specified on the command line.

### AzureResourceSchema multi-api

``` yaml $(azureresourceschema) && $(multiapi)
batch:
  - tag: schema-securityinsights-2020-01-01
  - tag: schema-securityinsights-2019-01-01-preview

```

Please also specify `--azureresourceschema-folder=<path to the root directory of your azure-resource-manager-schemas clone>`.

### Tag: schema-securityinsights-2020-01-01 and azureresourceschema

``` yaml $(tag) == 'schema-securityinsights-2020-01-01' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.SecurityInsights/stable/2020-01-01/SecurityInsights.json

```

### Tag: schema-securityinsights-2019-01-01-preview and azureresourceschema

``` yaml $(tag) == 'schema-securityinsights-2019-01-01-preview' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.SecurityInsights/preview/2019-01-01-preview/SecurityInsights.json

```

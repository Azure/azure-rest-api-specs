## AzureResourceSchema

These settings apply only when `--azureresourceschema` is specified on the command line.

### AzureResourceSchema multi-api

``` yaml $(azureresourceschema) && $(multiapi)
batch:
  - tag: schema-healthcareinterop-2025-05-01-preview

```

Please also specify `--azureresourceschema-folder=<path to the root directory of your azure-resource-manager-schemas clone>`.

### Tag: schema-healthcareinterop-2025-05-01-preview and azureresourceschema

``` yaml $(tag) == 'schema-healthcareinterop-2025-05-01-preview' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.HealthcareInterop/cloud/preview/2025-05-01-preview/cloud.json
  - Microsoft.HealthcareInterop/edge/preview/2025-05-01-preview/edge.json

```

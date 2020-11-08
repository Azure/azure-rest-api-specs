## AzureResourceSchema

These settings apply only when `--azureresourceschema` is specified on the command line.

### AzureResourceSchema multi-api

``` yaml $(azureresourceschema) && $(multiapi)
batch:
  - tag: schema-powerplatform-2020-10-30-preview

```

Please also specify `--azureresourceschema-folder=<path to the root directory of your azure-resource-manager-schemas clone>`.

### Tag: schema-powerplatform-2020-10-30-preview and azureresourceschema

``` yaml $(tag) == 'schema-powerplatform-2020-10-30-preview' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.PowerPlatform/preview/2020-10-30-preview/enterprisePolicy.json
  - Microsoft.PowerPlatform/preview/2020-10-30-preview/privateEndpointConnection.json
  - Microsoft.PowerPlatform/preview/2020-10-30-preview/privateLinkResources.json
  - Microsoft.PowerPlatform/preview/2020-10-30-preview/subnetResources.json

```

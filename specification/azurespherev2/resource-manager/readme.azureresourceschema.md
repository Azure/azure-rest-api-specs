## AzureResourceSchema

These settings apply only when `--azureresourceschema` is specified on the command line.

### AzureResourceSchema multi-api

``` yaml $(azureresourceschema) && $(multiapi)
batch:
  - tag: schema-azurespherev2-2022-09-01-privatepreview

```

Please also specify `--azureresourceschema-folder=<path to the root directory of your azure-resource-manager-schemas clone>`.

### Tag: schema-azurespherev2-2022-09-01-privatepreview and azureresourceschema

``` yaml $(tag) == 'schema-azurespherev2-2022-02-09-privatepreview' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.AzureSphereV2/preview/2022-09-01-privatepreview/azurespherev2.json

```

## AzureResourceSchema

These settings apply only when `--azureresourceschema` is specified on the command line.

### AzureResourceSchema multi-api

``` yaml $(azureresourceschema) && $(multiapi)
batch:
  - tag: schema-extendedlocation-2021-03-15-preview

```

Please also specify `--azureresourceschema-folder=<path to the root directory of your azure-resource-manager-schemas clone>`.

### Tag: schema-extendedlocation-2021-03-15-preview and azureresourceschema

``` yaml $(tag) == 'schema-extendedlocation-2021-03-15-preview' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.ExtendedLocation/preview/2021-03-15-preview/customlocations.json

```

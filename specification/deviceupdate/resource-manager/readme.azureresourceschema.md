## AzureResourceSchema

These settings apply only when `--azureresourceschema` is specified on the command line.

### AzureResourceSchema multi-api

``` yaml $(azureresourceschema) && $(multiapi)
batch:
  - tag: schema-deviceupdate-2020-03-01-preview

```

Please also specify `--azureresourceschema-folder=<path to the root directory of your azure-resource-manager-schemas clone>`.

### Tag: schema-deviceupdate-2020-03-01-preview and azureresourceschema

``` yaml $(tag) == 'schema-deviceupdate-2020-03-01-preview' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.DeviceUpdate/preview/2020-03-01-preview/deviceupdate.json

```

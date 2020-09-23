## AzureResourceSchema

These settings apply only when `--azureresourceschema` is specified on the command line.

### AzureResourceSchema multi-api

``` yaml $(azureresourceschema) && $(multiapi)
batch:
  - tag: schema-azuredata-2020-09-08-preview
  - tag: schema-azuredata-2019-07-24-preview

```

Please also specify `--azureresourceschema-folder=<path to the root directory of your azure-resource-manager-schemas clone>`.

### Tag: schema-azuredata-2020-09-08-preview and azureresourceschema

``` yaml $(tag) == 'schema-azuredata-2020-09-08-preview' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.AzureData/preview/2020-09-08-preview/azuredata.json

```

### Tag: schema-azuredata-2019-07-24-preview and azureresourceschema

``` yaml $(tag) == 'schema-azuredata-2019-07-24-preview' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.AzureData/preview/2019-07-24-preview/azuredata.json

```

## AzureResourceSchema

These settings apply only when `--azureresourceschema` is specified on the command line.

### AzureResourceSchema multi-api

``` yaml $(azureresourceschema) && $(multiapi)
batch:
  - tag: schema-azurearcdata-2021-03-02-preview

```

``` yaml $(azureresourceschema) && $(multiapi)
batch:
  - tag: schema-azurearcdata-2021-03-02-preview

```

Please also specify `--azureresourceschema-folder=<path to the root directory of your azure-resource-manager-schemas clone>`.

### Tag: schema-azurearcdata-2021-03-02-preview and azureresourceschema

``` yaml $(tag) == 'schema-azurearcdata-2021-03-02-preview' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.AzureArcData/preview/2021-03-02-preview/azurearcdata.json

```

### Tag: schema-azurearcdata-2021-03-02-preview and azureresourceschema

``` yaml $(tag) == 'schema-azurearcdata-2021-03-02-preview' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.AzureArcData/preview/2021-03-02-preview/azurearcdata.json

```

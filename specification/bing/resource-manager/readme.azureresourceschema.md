## AzureResourceSchema

These settings apply only when `--azureresourceschema` is specified on the command line.

### AzureResourceSchema multi-api

``` yaml $(azureresourceschema) && $(multiapi)
batch:
  - tag: schema-bing-2020-06-10
  - tag: schema-bing-2020-06-10-preview

```

Please also specify `--azureresourceschema-folder=<path to the root directory of your azure-resource-manager-schemas clone>`.

### Tag: schema-bing-2020-06-10 and azureresourceschema

``` yaml $(tag) == 'schema-bing-2020-06-10' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.Bing/stable/2020-06-10/bing.json

```

### Tag: schema-bing-2020-06-10-preview and azureresourceschema

``` yaml $(tag) == 'schema-bing-2020-06-10-preview' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.Bing/preview/2020-06-10-preview/bing.json

```

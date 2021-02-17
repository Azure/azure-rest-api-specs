## AzureResourceSchema

These settings apply only when `--azureresourceschema` is specified on the command line.

### AzureResourceSchema multi-api

``` yaml $(azureresourceschema) && $(multiapi)
batch:
  - tag: schema-cache-2021-03-01
  - tag: schema-cache-2020-10-01-preview

```

Please also specify `--azureresourceschema-folder=<path to the root directory of your azure-resource-manager-schemas clone>`.

### Tag: schema-cache-2021-03-01 and azureresourceschema

``` yaml $(tag) == 'schema-cache-2021-03-01' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.Cache/stable/2021-03-01/redisenterprise.json

```

### Tag: schema-cache-2020-10-01-preview and azureresourceschema

``` yaml $(tag) == 'schema-cache-2020-10-01-preview' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.Cache/preview/2020-10-01-preview/redisenterprise.json

```

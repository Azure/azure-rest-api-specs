## AzureResourceSchema

These settings apply only when `--azureresourceschema` is specified on the command line.

### AzureResourceSchema multi-api

``` yaml $(azureresourceschema) && $(multiapi)
batch:
  - tag: schema-testbase-2020-12-16-preview
  - tag: schema-testbase-2021-09-01-preview
  
```

Please also specify `--azureresourceschema-folder=<path to the root directory of your azure-resource-manager-schemas clone>`.

### Tag: schema-testbase-2020-12-16-preview and azureresourceschema

``` yaml $(tag) == 'schema-testbase-2020-12-16-preview' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.TestBase/preview/2020-12-16-preview/testbase.json
```

### Tag: schema-testbase-2021-09-01-preview and azureresourceschema

``` yaml $(tag) == 'schema-testbase-2021-09-01-preview' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.TestBase/preview/2021-09-01-preview/testbase.json
```
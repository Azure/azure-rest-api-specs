## AzureResourceSchema

These settings apply only when `--azureresourceschema` is specified on the command line.

### AzureResourceSchema multi-api

``` yaml $(azureresourceschema) && $(multiapi)
batch:
  - tag: schema-maps-2020-02-01-preview
  - tag: schema-maps-2018-05-01
  - tag: schema-maps-2017-01-01-preview

```

Please also specify `--azureresourceschema-folder=<path to the root directory of your azure-resource-manager-schemas clone>`.

### Tag: schema-maps-2020-02-01-preview and azureresourceschema

``` yaml $(tag) == 'schema-maps-2020-02-01-preview' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.Maps/preview/2020-02-01-preview/maps-management.json

```

### Tag: schema-maps-2018-05-01 and azureresourceschema

``` yaml $(tag) == 'schema-maps-2018-05-01' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.Maps/stable/2018-05-01/maps-management.json

```

### Tag: schema-maps-2017-01-01-preview and azureresourceschema

``` yaml $(tag) == 'schema-maps-2017-01-01-preview' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.Maps/stable/2017-01-01-preview/maps-management.json

```

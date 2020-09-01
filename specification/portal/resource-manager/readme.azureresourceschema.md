## AzureResourceSchema

These settings apply only when `--azureresourceschema` is specified on the command line.

### AzureResourceSchema multi-api

``` yaml $(azureresourceschema) && $(multiapi)
batch:
  - tag: schema-portal-2019-01-01-preview
  - tag: schema-portal-2018-10-01-preview
  - tag: schema-portal-2015-08-01-preview

```

Please also specify `--azureresourceschema-folder=<path to the root directory of your azure-resource-manager-schemas clone>`.

### Tag: schema-portal-2019-01-01-preview and azureresourceschema

``` yaml $(tag) == 'schema-portal-2019-01-01-preview' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.Portal/preview/2019-01-01-preview/portal.json

```

### Tag: schema-portal-2018-10-01-preview and azureresourceschema

``` yaml $(tag) == 'schema-portal-2018-10-01-preview' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.Portal/preview/2018-10-01-preview/portal.json

```

### Tag: schema-portal-2015-08-01-preview and azureresourceschema

``` yaml $(tag) == 'schema-portal-2015-08-01-preview' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.Portal/preview/2015-08-01-preview/portal.json

```

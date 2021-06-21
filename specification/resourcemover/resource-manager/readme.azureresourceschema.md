## AzureResourceSchema

These settings apply only when `--azureresourceschema` is specified on the command line.

### AzureResourceSchema multi-api

``` yaml $(azureresourceschema) && $(multiapi)
batch:
  - tag: schema-migrate-2021-01-01
  - tag: schema-migrate-2019-10-01-preview

```

Please also specify `--azureresourceschema-folder=<path to the root directory of your azure-resource-manager-schemas clone>`.

### Tag: schema-migrate-2021-01-01 and azureresourceschema

``` yaml $(tag) == 'schema-migrate-2021-01-01' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.Migrate/stable/2021-01-01/resourcemovercollection.json

```

### Tag: schema-migrate-2019-10-01-preview and azureresourceschema

``` yaml $(tag) == 'schema-migrate-2019-10-01-preview' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.Migrate/preview/2019-10-01-preview/resourcemovercollection.json

```

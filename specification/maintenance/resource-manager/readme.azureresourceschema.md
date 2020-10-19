## AzureResourceSchema

These settings apply only when `--azureresourceschema` is specified on the command line.

### AzureResourceSchema multi-api

``` yaml $(azureresourceschema) && $(multiapi)
batch:
  - tag: schema-maintenance-2020-07-01-preview
  - tag: schema-maintenance-2020-04-01
  - tag: schema-maintenance-2018-06-01-preview

```

Please also specify `--azureresourceschema-folder=<path to the root directory of your azure-resource-manager-schemas clone>`.

### Tag: schema-maintenance-2020-07-01-preview and azureresourceschema

``` yaml $(tag) == 'schema-maintenance-2020-07-01-preview' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.Maintenance/preview/2020-07-01-preview/Maintenance.json

```

### Tag: schema-maintenance-2020-04-01 and azureresourceschema

``` yaml $(tag) == 'schema-maintenance-2020-04-01' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.Maintenance/stable/2020-04-01/Maintenance.json

```

### Tag: schema-maintenance-2018-06-01-preview and azureresourceschema

``` yaml $(tag) == 'schema-maintenance-2018-06-01-preview' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.Maintenance/preview/2018-06-01-preview/Maintenance.json

```

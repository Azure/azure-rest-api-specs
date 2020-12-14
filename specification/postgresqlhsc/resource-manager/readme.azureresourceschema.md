## AzureResourceSchema

These settings apply only when `--azureresourceschema` is specified on the command line.

### AzureResourceSchema multi-api

``` yaml $(azureresourceschema) && $(multiapi)
batch:
  - tag: schema-dbforpostgresqlhsc-2020-10-05-privatepreview
```

Please also specify `--azureresourceschema-folder=<path to the root directory of your azure-resource-manager-schemas clone>`.

### Tag: schema-dbforpostgresqlhsc2020-10-05-privatepreview and azureresourceschema

``` yaml $(tag) == 'schema-dbforpostgresqlhsc-2020-10-05-privatepreview' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.DBforPostgreSQL/preview/2020-10-05-privatepreview/postgresqlhsc.json
```

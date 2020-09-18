## AzureResourceSchema

These settings apply only when `--azureresourceschema` is specified on the command line.

### AzureResourceSchema multi-api

``` yaml $(azureresourceschema) && $(multiapi)
batch:
  - tag: schema-offazure-2020-07-07
  - tag: schema-offazure-2020-01-01
  - tag: schema-migrate-2019-10-01
  - tag: schema-migrate-2018-02-02

```

Please also specify `--azureresourceschema-folder=<path to the root directory of your azure-resource-manager-schemas clone>`.

### Tag: schema-offazure-2020-07-07 and azureresourceschema

``` yaml $(tag) == 'schema-offazure-2020-07-07' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.OffAzure/stable/2020-07-07/migrate.json

```

### Tag: schema-offazure-2020-01-01 and azureresourceschema

``` yaml $(tag) == 'schema-offazure-2020-01-01' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.OffAzure/stable/2020-01-01/migrate.json

```

### Tag: schema-migrate-2019-10-01 and azureresourceschema

``` yaml $(tag) == 'schema-migrate-2019-10-01' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.Migrate/stable/2019-10-01/migrate.json

```

### Tag: schema-migrate-2018-02-02 and azureresourceschema

``` yaml $(tag) == 'schema-migrate-2018-02-02' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.Migrate/stable/2018-02-02/migrate.json

```

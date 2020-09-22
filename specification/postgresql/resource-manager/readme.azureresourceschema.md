## AzureResourceSchema

These settings apply only when `--azureresourceschema` is specified on the command line.

### AzureResourceSchema multi-api

``` yaml $(azureresourceschema) && $(multiapi)
batch:
  - tag: schema-dbforpostgresql-2020-01-01
  - tag: schema-dbforpostgresql-2018-06-01
  - tag: schema-dbforpostgresql-2017-12-01-preview
  - tag: schema-dbforpostgresql-2017-12-01

```

Please also specify `--azureresourceschema-folder=<path to the root directory of your azure-resource-manager-schemas clone>`.

### Tag: schema-dbforpostgresql-2020-01-01 and azureresourceschema

``` yaml $(tag) == 'schema-dbforpostgresql-2020-01-01' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.DBforPostgreSQL/stable/2020-01-01/DataEncryptionKeys.json

```

### Tag: schema-dbforpostgresql-2018-06-01 and azureresourceschema

``` yaml $(tag) == 'schema-dbforpostgresql-2018-06-01' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.DBforPostgreSQL/stable/2018-06-01/PrivateEndpointConnections.json
  - Microsoft.DBforPostgreSQL/stable/2018-06-01/PrivateLinkResources.json

```

### Tag: schema-dbforpostgresql-2017-12-01-preview and azureresourceschema

``` yaml $(tag) == 'schema-dbforpostgresql-2017-12-01-preview' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.DBforPostgreSQL/preview/2017-12-01-preview/postgresql.json

```

### Tag: schema-dbforpostgresql-2017-12-01 and azureresourceschema

``` yaml $(tag) == 'schema-dbforpostgresql-2017-12-01' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.DBforPostgreSQL/stable/2017-12-01/postgresql.json
  - Microsoft.DBforPostgreSQL/stable/2017-12-01/ServerSecurityAlertPolicies.json

```

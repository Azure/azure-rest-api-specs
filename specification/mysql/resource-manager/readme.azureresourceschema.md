## AzureResourceSchema

These settings apply only when `--azureresourceschema` is specified on the command line.

### AzureResourceSchema multi-api

``` yaml $(azureresourceschema) && $(multiapi)
batch:
  - tag: schema-dbformysql-2020-01-01
  - tag: schema-dbformysql-2018-06-01
  - tag: schema-dbformysql-2017-12-01-preview
  - tag: schema-dbformysql-2017-12-01

```

Please also specify `--azureresourceschema-folder=<path to the root directory of your azure-resource-manager-schemas clone>`.

### Tag: schema-dbformysql-2020-01-01 and azureresourceschema

``` yaml $(tag) == 'schema-dbformysql-2020-01-01' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.DBforMySQL/stable/2020-01-01/DataEncryptionKeys.json
  - Microsoft.DBforMySQL/stable/2020-01-01/Servers.json

```

### Tag: schema-dbformysql-2018-06-01 and azureresourceschema

``` yaml $(tag) == 'schema-dbformysql-2018-06-01' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.DBforMySQL/stable/2018-06-01/QueryPerformanceInsights.json
  - Microsoft.DBforMySQL/stable/2018-06-01/PerformanceRecommendations.json
  - Microsoft.DBforMySQL/stable/2018-06-01/PrivateEndpointConnections.json
  - Microsoft.DBforMySQL/stable/2018-06-01/PrivateLinkResources.json

```

### Tag: schema-dbformysql-2017-12-01-preview and azureresourceschema

``` yaml $(tag) == 'schema-dbformysql-2017-12-01-preview' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.DBforMySQL/preview/2017-12-01-preview/mysql.json

```

### Tag: schema-dbformysql-2017-12-01 and azureresourceschema

``` yaml $(tag) == 'schema-dbformysql-2017-12-01' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.DBforMySQL/stable/2017-12-01/mysql.json
  - Microsoft.DBforMySQL/stable/2017-12-01/ServerSecurityAlertPolicies.json

```

## AzureResourceSchema

These settings apply only when `--azureresourceschema` is specified on the command line.

### AzureResourceSchema multi-api

``` yaml $(azureresourceschema) && $(multiapi)
batch:
  - tag: schema-dbformariadb-2020-01-01
  - tag: schema-dbformariadb-2018-06-01-preview
  - tag: schema-dbformariadb-2018-06-01

```

Please also specify `--azureresourceschema-folder=<path to the root directory of your azure-resource-manager-schemas clone>`.

### Tag: schema-dbformariadb-2020-01-01 and azureresourceschema

``` yaml $(tag) == 'schema-dbformariadb-2020-01-01' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.DBforMariaDB/stable/2020-01-01/Servers.json

```

### Tag: schema-dbformariadb-2018-06-01-preview and azureresourceschema

``` yaml $(tag) == 'schema-dbformariadb-2018-06-01-preview' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.DBforMariaDB/preview/2018-06-01-preview/mariadb.json

```

### Tag: schema-dbformariadb-2018-06-01 and azureresourceschema

``` yaml $(tag) == 'schema-dbformariadb-2018-06-01' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.DBforMariaDB/stable/2018-06-01/mariadb.json
  - Microsoft.DBforMariaDB/stable/2018-06-01/QueryPerformanceInsights.json
  - Microsoft.DBforMariaDB/stable/2018-06-01/PerformanceRecommendations.json
  - Microsoft.DBforMariaDB/stable/2018-06-01/PrivateEndpointConnections.json
  - Microsoft.DBforMariaDB/stable/2018-06-01/PrivateLinkResources.json
  - Microsoft.DBforMariaDB/stable/2018-06-01/ServerSecurityAlertPolicies.json

```

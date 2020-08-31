## AzureResourceSchema

These settings apply only when `--azureresourceschema` is specified on the command line.

### AzureResourceSchema multi-api

``` yaml $(azureresourceschema) && $(multiapi)
# include the azure profile definitions from the standard location
require: ../../../profiles/readme.md

output-folder: $(azureresourceschema-folder)/schemas

# all the input files across all versions
input-file:
  - Microsoft.DBforMariaDB/preview/2018-06-01-preview/mariadb.json
  - Microsoft.DBforMariaDB/stable/2018-06-01/mariadb.json
  - Microsoft.DBforMariaDB/stable/2018-06-01/QueryPerformanceInsights.json
  - Microsoft.DBforMariaDB/stable/2018-06-01/PerformanceRecommendations.json
  - Microsoft.DBforMariaDB/stable/2018-06-01/PrivateEndpointConnections.json
  - Microsoft.DBforMariaDB/stable/2018-06-01/PrivateLinkResources.json
  - Microsoft.DBforMariaDB/stable/2018-06-01/ServerSecurityAlertPolicies.json
  - Microsoft.DBforMariaDB/preview/2018-06-01-privatepreview/mariadb.json
  - Microsoft.DBforMariaDB/preview/2018-06-01-privatepreview/PrivateEndpointConnections.json
  - Microsoft.DBforMariaDB/preview/2018-06-01-privatepreview/PrivateLinkResources.json
  - Microsoft.DBforMariaDB/preview/2020-01-01-privatepreview/DataEncryptionKeys.json
  - Microsoft.DBforMariaDB/stable/2020-01-01/Servers.json

```
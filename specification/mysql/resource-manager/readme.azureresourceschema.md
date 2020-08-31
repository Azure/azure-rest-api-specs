## AzureResourceSchema

These settings apply only when `--azureresourceschema` is specified on the command line.

### AzureResourceSchema multi-api

``` yaml $(azureresourceschema) && $(multiapi)
# include the azure profile definitions from the standard location
require: ../../../profiles/readme.md

output-folder: $(azureresourceschema-folder)/schemas

# all the input files across all versions
input-file:
  - Microsoft.DBforMySQL/preview/2017-12-01-preview/mysql.json
  - Microsoft.DBforMySQL/stable/2017-12-01/mysql.json
  - Microsoft.DBforMySQL/stable/2017-12-01/ServerSecurityAlertPolicies.json
  - Microsoft.DBforMySQL/preview/2018-06-01-privatepreview/mysql.json
  - Microsoft.DBforMySQL/preview/2018-06-01-privatepreview/PrivateEndpointConnections.json
  - Microsoft.DBforMySQL/preview/2018-06-01-privatepreview/PrivateLinkResources.json
  - Microsoft.DBforMySQL/stable/2018-06-01/QueryPerformanceInsights.json
  - Microsoft.DBforMySQL/stable/2018-06-01/PerformanceRecommendations.json
  - Microsoft.DBforMySQL/stable/2018-06-01/PrivateEndpointConnections.json
  - Microsoft.DBforMySQL/stable/2018-06-01/PrivateLinkResources.json
  - Microsoft.DBforMySQL/preview/2020-01-01-privatepreview/DataEncryptionKeys.json
  - Microsoft.DBforMySQL/stable/2020-01-01/DataEncryptionKeys.json
  - Microsoft.DBforMySQL/stable/2020-01-01/Servers.json
  - Microsoft.DBforMySQL/preview/2020-07-01-privatepreview/mysql.json

```
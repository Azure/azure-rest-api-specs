## AzureResourceSchema

These settings apply only when `--azureresourceschema` is specified on the command line.

### AzureResourceSchema multi-api

``` yaml $(azureresourceschema) && $(multiapi)
# include the azure profile definitions from the standard location
require: ../../../profiles/readme.md

output-folder: $(azureresourceschema-folder)/schemas

# all the input files across all versions
input-file:
  - Microsoft.DBforPostgreSQL/preview/2020-02-14-privatepreview/postgresql.json
  - Microsoft.DBforPostgreSQL/preview/2020-01-01-privatepreview/DataEncryptionKeys.json
  - Microsoft.DBforPostgreSQL/stable/2017-12-01/postgresql.json
  - Microsoft.DBforPostgreSQL/stable/2017-12-01/ServerSecurityAlertPolicies.json
  - Microsoft.DBforPostgreSQL/stable/2018-06-01/PrivateEndpointConnections.json
  - Microsoft.DBforPostgreSQL/stable/2018-06-01/PrivateLinkResources.json
  - Microsoft.DBforPostgreSQL/stable/2020-01-01/DataEncryptionKeys.json
  - Microsoft.DBforPostgreSQL/preview/2018-06-01-privatepreview/PrivateEndpointConnections.json
  - Microsoft.DBforPostgreSQL/preview/2018-06-01-privatepreview/PrivateLinkResources.json
  - Microsoft.DBforPostgreSQL/preview/2017-12-01-preview/postgresql.json

```
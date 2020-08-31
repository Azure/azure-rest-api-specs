## AzureResourceSchema

These settings apply only when `--azureresourceschema` is specified on the command line.

### AzureResourceSchema multi-api

``` yaml $(azureresourceschema) && $(multiapi)
# include the azure profile definitions from the standard location
require: ../../../profiles/readme.md

output-folder: $(azureresourceschema-folder)/schemas

# all the input files across all versions
input-file:
  - Microsoft.Synapse/preview/2019-06-01-preview/bigDataPool.json
  - Microsoft.Synapse/preview/2019-06-01-preview/checkNameAvailability.json
  - Microsoft.Synapse/preview/2019-06-01-preview/firewallRule.json
  - Microsoft.Synapse/preview/2019-06-01-preview/operations.json
  - Microsoft.Synapse/preview/2019-06-01-preview/sqlPool.json
  - Microsoft.Synapse/preview/2019-06-01-preview/workspace.json
  - Microsoft.Synapse/preview/2019-06-01-preview/integrationRuntime.json
  - Microsoft.Synapse/preview/2019-06-01-preview/privateLinkResources.json
  - Microsoft.Synapse/preview/2019-06-01-preview/privateEndpointConnections.json
  - Microsoft.Synapse/preview/2019-06-01-preview/privatelinkhub.json
  - Microsoft.Synapse/preview/2020-04-01-preview/operations.json
  - Microsoft.Synapse/preview/2020-04-01-preview/sqlPool.json
  - Microsoft.Synapse/preview/2020-04-01-preview/sqlDatabase.json

```
## AzureResourceSchema

These settings apply only when `--azureresourceschema` is specified on the command line.

### AzureResourceSchema multi-api

``` yaml $(azureresourceschema) && $(multiapi)
batch:
  - tag: schema-synapse-2020-04-01-preview
  - tag: schema-synapse-2019-06-01-preview
  - tag: schema-synapse-2020-12-01

```

Please also specify `--azureresourceschema-folder=<path to the root directory of your azure-resource-manager-schemas clone>`.

### Tag: schema-synapse-2020-04-01-preview and azureresourceschema

``` yaml $(tag) == 'schema-synapse-2020-04-01-preview' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.Synapse/preview/2020-04-01-preview/operations.json
  - Microsoft.Synapse/preview/2020-04-01-preview/sqlPool.json
  - Microsoft.Synapse/preview/2020-04-01-preview/sqlDatabase.json

```

### Tag: schema-synapse-2019-06-01-preview and azureresourceschema

``` yaml $(tag) == 'schema-synapse-2019-06-01-preview' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
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
  - Microsoft.Synapse/preview/2019-06-01-preview/sqlServer.json
  - Microsoft.Synapse/preview/2019-06-01-preview/keys.json

```
### Tag: schema-synapse-2020-12-01 and azureresourceschema

``` yaml $(tag) == 'schema-synapse-2020-12-01' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.Synapse/stable/2020-12-01/bigDataPool.json
  - Microsoft.Synapse/stable/2020-12-01/checkNameAvailability.json
  - Microsoft.Synapse/stable/2020-12-01/firewallRule.json
  - Microsoft.Synapse/stable/2020-12-01/operations.json
  - Microsoft.Synapse/stable/2020-12-01/sqlPool.json
  - Microsoft.Synapse/stable/2020-12-01/workspace.json
  - Microsoft.Synapse/stable/2020-12-01/integrationRuntime.json
  - Microsoft.Synapse/stable/2020-12-01/privateLinkResources.json
  - Microsoft.Synapse/stable/2020-12-01/privateEndpointConnections.json
  - Microsoft.Synapse/stable/2020-12-01/privatelinkhub.json
  - Microsoft.Synapse/stable/2020-12-01/sqlServer.json
  - Microsoft.Synapse/stable/2020-12-01/keys.json

```
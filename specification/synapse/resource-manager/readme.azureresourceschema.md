## AzureResourceSchema

These settings apply only when `--azureresourceschema` is specified on the command line.

### AzureResourceSchema multi-api

``` yaml $(azureresourceschema) && $(multiapi)
batch:
  - tag: schema-synapse-2020-04-01-preview
  - tag: schema-synapse-2019-06-01-preview

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

```

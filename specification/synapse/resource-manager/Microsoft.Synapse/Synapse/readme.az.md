## AZ
These settings apply only when `--az` is specified on the command line.

``` yaml $(az) && $(target-mode) == 'core'
az:
  extensions: synapse
  namespace: azure.mgmt.synapse
  package-name: azure-mgmt-synapse
az-output-folder: $(azure-cli-folder)/src/azure-cli/azure/cli/command_modules/synapse
python-sdk-output-folder: "$(az-output-folder)/vendored_sdks/synapse"
input-file:
  - Microsoft.Synapse/preview/2021-06-01-preview/kustoPool.json

directive:
  - where:
      group: 'synapse kusto-pool-database-principal-assignment'
    set:
      group: 'synapse kusto database-principal-assignment'
  - where:
      group: 'synapse kusto-pool-attached-database-configuration'
    set:
      group: 'synapse kusto attached-database-configuration'
  - where:
      group: 'synapse kusto-pool-data-connection'
    set:
      group: 'synapse kusto data-connection'
  - where:
      group: 'synapse kusto-pool-database'
    set:
      group: 'synapse kusto database'
  - where:
      group: 'synapse kusto-pool-principal-assignment'
    set:
      group: 'synapse kusto pool-principal-assignment'
  - where:
      group: 'synapse kusto-pool'
    set:
      group: 'synapse kusto pool'
  - where:
      group: 'synapse kusto-pool-data-connection event-grid'
    set:
      group: 'synapse kusto data-connection event-grid'
  - where:
      group: 'synapse kusto-pool-data-connection event-hub'
    set:
      group: 'synapse kusto data-connection event-hub'
  - where:
      group: 'synapse kusto-pool-data-connection iot-hub'
    set:
      group: 'synapse kusto data-connection iot-hub'

cli:
    cli-directive:
      - where:
            group: 'KustoPoolDataConnections'
            op: 'CreateOrUpdate|Update'
            param: 'parameters'
        poly-resource: true
      - where:
            group: 'KustoPoolDataConnections'
            op: 'dataConnectionValidation'
        removed: true
      - where:
            group: 'KustoPools'
            op: 'AddLanguageExtensions'
        removed: true
      - where:
            group: 'KustoPools'
            op: 'RemoveLanguageExtensions'
        removed: true
      - where:
            group: 'KustoPools'
            op: 'DetachFollowerDatabases'
        removed: true
      - where:
            group: 'KustoPools'
            op: 'CreateOrUpdate|Update'
        removed: true    
```

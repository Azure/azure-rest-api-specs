## AZ

These settings apply only when `--az` is specified on the command line.

``` yaml $(az) && $(target-mode) != 'core'
az:
    extensions: redisenterprise
    namespace: azure.mgmt.redisenterprise
    package-name: azure-mgmt-redisenterprise
az-output-folder: $(azure-cli-extension-folder)/src/redisenterprise
python-sdk-output-folder: "$(az-output-folder)/azext_redisenterprise/vendored_sdks/redisenterprise"
```
``` yaml $(az) && $(target-mode) == 'core'
az:
    extensions: redisenterprise
    namespace: azure.mgmt.redisenterprise
    package-name: azure-mgmt-redisenterprise
az-output-folder: $(azure-cli-folder)/src/azure-cli/azure/cli/command_modules/redisenterprise
python-sdk-output-folder: "$(az-output-folder)/vendored_sdks/redisenterprise"
```

Additional configuration specific for Azure CLI

``` yaml $(az)
extension-mode: stable

directive:
  - where:
      group: redisenterprise redis-enterprise
    set:
      group: redisenterprise
  - where:
      command: redisenterprise database list-key
    set:
      command: redisenterprise database list-keys

cli:
    cli-directive:
      - where:
          group: '*'
          op: '*'
          param: 'sku'
        cli-flatten: true
      - where:
          group: 'RedisEnterprise'
          op: 'Create'
          param: 'name'
        required: true
      - where:
          group: '*'
          op: '*'
          param: 'name'
        name: 'sku'
      - where:
          group: '*'
          op: '*'
          param: 'clusterName'
        alias:
          - 'cluster_name'
          - 'name'
          - 'n'
      - where:
          group: '*'
          op: '*'
          param: 'zones'
        alias:
          - 'zones'
          - 'z'
      - where:
          group: 'Databases'
          op: 'Update'
          param: 'clusteringPolicy'
        hidden: true
      - where:
          group: 'Databases'
          op: 'Update'
          param: 'modules'
        hidden: true
      - where:
          group: 'Databases'
          op: 'Update'
          param: 'port'
        hidden: true
      - where:
          group: '*'
          op: '*'
          param: 'databaseName'
        default-value: 'default'
        hidden: true
      - where:
          group: 'PrivateEndpointConnections'
        hidden: true
      - where:
          group: 'PrivateLinkResources'
        hidden: true
      - where:
          group: '*'
          op: '*'
          param: 'persistence'
        set:
          extensionMode: 'preview'
```

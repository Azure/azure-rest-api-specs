## CLI

These settings apply only when `--cli` is specified on the command line.

``` yaml $(cli)
cli:
  cli-name: appconfiguration
  namespace: azure.mgmt.appconfiguration
  package-name: azure-mgmt-appconfiguration
  debug: true
  test-setup:
    - name: ConfigurationStores_Create
    - name: ConfigurationStores_Get
    - name: ConfigurationStores_CheckNameAvailable
    - name: ConfigurationStores_ListKeys
    - name: ConfigurationStores_List

clicommon:
    cli-directive:
      - select: 'parameter'
        where:
            parameter: '(config_store_creation_parameter|regenerate_key_parameter|check_name_availability_parameter)'
        set:
            hide: 'true'
      - select: 'operation'
        where:
            operationGroup: 'configuration_stores'
            operation: 'update'
        set:
            hide: 'true'
      - select: 'parameter'
        where:
            parameter: 'config_store_name'
        set:
            name: 'name'
      - select: 'operationGroup'
        where:
            operationGroup: 'operations'
        set:
            name: 'stores'
```


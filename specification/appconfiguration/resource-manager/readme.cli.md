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
  cli-directive:
    - select: 'parameter'
      where:
          parameter: '(configStoreCreationParameters|regenerateKeyParameters|checkNameAvailabilityParameters)'
      hidden: 'true'
    - select: 'operation'
      where:
          operationGroup: 'ConfigurationStores'
          operation: 'update'
      hidden: 'true'
    - select: 'parameter'
      where:
          parameter: 'configStoreName'
      name: 'name'
    - select: 'operationGroup'
      where:
          operationGroup: 'Operations'
      name: 'stores'
```


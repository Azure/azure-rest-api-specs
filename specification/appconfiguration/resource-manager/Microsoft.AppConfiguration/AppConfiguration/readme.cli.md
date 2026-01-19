## CLI

These settings apply only when `--cli` is specified on the command line.

``` yaml $(cli)
cli:
  cli-name: appconfiguration
  namespace: azure.mgmt.appconfiguration
  package-name: azure-mgmt-appconfiguration
  debug: true
  test-scenario:
    - name: /ConfigurationStores/put/ConfigurationStores_Create
    - name: /ConfigurationStores/put/ConfigurationStores_Create_WithIdentity
      disabled: true
    - name: /PrivateEndpointConnections/put/PrivateEndpointConnection_CreateOrUpdate
      disabled: true
    - name: /PrivateEndpointConnections/get/PrivateEndpointConnection_GetConnection
      disabled: true
    - name: /PrivateLinkResources/get/PrivateLinkResources_Get
      disabled: true
    - name: /PrivateEndpointConnections/get/PrivateEndpointConnection_List
      disabled: true
    - name: /PrivateLinkResources/get/PrivateLinkResources_ListGroupIds
      disabled: true
    - name: /ConfigurationStores/get/ConfigurationStores_Get
    - name: /ConfigurationStores/get/ConfigurationStores_ListByResourceGroup
    - name: /ConfigurationStores/get/ConfigurationStores_List
    - name: /ConfigurationStores/post/ConfigurationStores_RegenerateKey
      disabled: true
    - name: /ConfigurationStores/post/ConfigurationStores_ListKeyValue
      disabled: true
    - name: /ConfigurationStores/post/ConfigurationStores_ListKeys
    - name: /ConfigurationStores/patch/ConfigurationStores_Update
      disabled: true
    - name: /ConfigurationStores/patch/ConfigurationStores_Update_WithIdentity
      disabled: true
    - name: /Operations/post/ConfigurationStores_CheckNameNotAvailable
      disabled: true
    - name: /Operations/post/ConfigurationStores_CheckNameAvailable
      disabled: true
    - name: /PrivateEndpointConnections/delete/PrivateEndpointConnections_Delete
      disabled: true
    - name: /ConfigurationStores/delete/ConfigurationStores_Delete
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


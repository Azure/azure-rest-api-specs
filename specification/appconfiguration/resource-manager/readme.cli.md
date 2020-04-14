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
    - name: /PrivateEndpointConnections/put/PrivateEndpointConnection_CreateOrUpdate
    - name: /PrivateEndpointConnections/get/PrivateEndpointConnection_GetConnection
    - name: /PrivateLinkResources/get/PrivateLinkResources_Get
    - name: /PrivateEndpointConnections/get/PrivateEndpointConnection_List
    - name: /PrivateLinkResources/get/PrivateLinkResources_ListGroupIds
    - name: /ConfigurationStores/get/ConfigurationStores_Get
    - name: /ConfigurationStores/get/ConfigurationStores_ListByResourceGroup
    - name: /ConfigurationStores/get/ConfigurationStores_List
    - name: /ConfigurationStores/post/ConfigurationStores_RegenerateKey
    - name: /ConfigurationStores/post/ConfigurationStores_ListKeyValue
    - name: /ConfigurationStores/post/ConfigurationStores_ListKeys
    - name: /ConfigurationStores/patch/ConfigurationStores_Update
    - name: /ConfigurationStores/patch/ConfigurationStores_Update_WithIdentity
    - name: /Operations/post/ConfigurationStores_CheckNameNotAvailable
    - name: /Operations/post/ConfigurationStores_CheckNameAvailable
    - name: /PrivateEndpointConnections/delete/PrivateEndpointConnections_Delete
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


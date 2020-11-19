## CLI

These settings apply only when `--cli` is specified on the command line.

``` yaml $(cli)
cli:
  cli-name: storagesync
  package-name: azure-mgmt-storagesync
  namespace: azure.mgmt.storagesync
  test-scenario:
    - name: StorageSyncServices_Create
    - name: SyncGroups_Create
    - name: RegisteredServers_Create
    - name: CloudEndpoints_Create
    - name: ServerEndpoints_Create
    - name: ServerEndpoints_Get
    - name: CloudEndpoints_Get
    - name: ServerEndpoints_ListBySyncGroup
    - name: CloudEndpoints_ListBySyncGroup
    - name: RegisteredServers_Get
    - name: Workflows_Get
    - name: SyncGroups_Get
    - name: Workflows_Get
    - name: RegisteredServers_ListByStorageSyncService
    - name: SyncGroups_ListByStorageSyncService
    - name: Workflows_ListByStorageSyncService
    - name: StorageSyncServices_Get
    - name: StorageSyncServices_ListByResourceGroup
    - name: StorageSyncServices_ListBySubscription
    - name: Operations_List
    - name: CloudEndpoints_TriggerChangeDetection
    - name: CloudEndpoints_restoreheartbeat
    - name: ServerEndpoints_recallAction
    - name: CloudEndpoints_PostRestore
    - name: CloudEndpoints_PreRestore
    - name: CloudEndpoints_PostBackup
    - name: CloudEndpoints_PreBackup
    - name: ServerEndpoints_Update
    - name: RegisteredServers_triggerRollover
    - name: Workflows_Abort
    - name: StorageSyncServices_Update
    - name: StorageSyncServiceCheckNameAvailability_AlreadyExists
    - name: StorageSyncServiceCheckNameAvailability_Available
    - name: ServerEndpoints_Delete
    - name: CloudEndpoints_Delete
    - name: RegisteredServers_Delete
    - name: SyncGroups_Delete
    - name: StorageSyncServices_Delete
```
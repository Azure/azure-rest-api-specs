## CLI

These settings apply only when `--cli` is specified on the command line.

``` yaml $(cli)
cli:
  namespace: azure.mgmt.maintenance
  flatten-all: true
  test-scenario:
    - name: MaintenanceConfigurations_CreateOrUpdateForResource
    - name: ApplyUpdates_CreateOrUpdate
    - name: ConfigurationAssignments_CreateOrUpdate
    - name: ApplyUpdates_CreateOrUpdateParent
    - name: ConfigurationAssignments_CreateOrUpdateParent
    - name: ApplyUpdates_GetParent
    - name: ConfigurationAssignments_ListParent
    - name: Updates_ListParent
    - name: ApplyUpdates_Get
    - name: ConfigurationAssignments_List
    - name: Updates_List
    - name: MaintenanceConfigurations_GetForResource
    - name: MaintenanceConfigurations_List
    - name: Operations_List
    - name: MaintenanceConfigurations_UpdateForResource
    - name: ConfigurationAssignments_DeleteParent
    - name: ConfigurationAssignments_Delete
    - name: MaintenanceConfigurations_DeleteForResource
```

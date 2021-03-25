 CLI

These settings apply only when `--cli` is specified on the command line.

``` yaml $(cli)
cli:
  namespace: azure.mgmt.windowsiot
  test-scenario:
    - name: Service_List
    - name: Service_Create
    - name: Service_ListByResourceGroup
    - name: Service_Update
    - name: Services_GetProperties
    - name: Service_Delete
```

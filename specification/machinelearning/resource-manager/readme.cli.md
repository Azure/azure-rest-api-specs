## CLI

These settings apply only when `--cli` is specified on the command line.

``` yaml $(cli)
cli:
  cli-name: ml
  package-name: azure-mgmt-machinelearning
  namespace: azure.mgmt.machinelearning
  test-scenario:
    - name: WorkspaceCreate
    - name: WorkspaceGet
    - name: WorkspaceListResourceGroup
    - name: WorkspaceGetBySubscription
    - name: ListWorkspaceKeys
    - name: ResyncStorageKeys
    - name: WorkspaceUpdate
    - name: WorkspaceDelete
```

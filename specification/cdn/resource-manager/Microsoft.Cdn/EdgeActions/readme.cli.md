## CLI

These settings apply only when `--cli` is specified on the command line.

``` yaml $(cli)
cli:
  cli-name: edgeactions
  package-name: azure-mgmt-edgeactions
  namespace: azure.mgmt.edgeactions
  test-scenario:
  - name: EdgeActions_Create
    - name: EdgeActions_Get
    - name: EdgeActions_ListByProfile
  - name: EdgeActionsVersions_Create
  - name: EdgeActionsVersions_Get
  - name: EdgeActionsVersions_ListByEdgeAction
  - name: EdgeActionsExecutionFilters_Create
  - name: EdgeActionsExecutionFilters_Get
  - name: EdgeActionsExecutionFilters_ListByEdgeAction
  # Removed Operations_* entries; operations interface excluded in TypeSpec per 2024 baseline
  - name: EdgeActionsVersions_Update
  - name: EdgeActionsExecutionFilters_Update
    - name: EdgeActions_Update
  - name: EdgeActionsExecutionFilters_Delete
  - name: EdgeActionsVersions_Delete
    - name: EdgeActions_Delete
```

## CLI

These settings apply only when `--cli` is specified on the command line.

``` yaml $(cli)
cli:
  cli-name: edgeactions
  package-name: azure-mgmt-edgeactions
  namespace: azure.mgmt.edgeactions
  test-scenario:
    - name: EdgeActions_CreateOrUpdate
    - name: EdgeActions_Get
    - name: EdgeActions_ListByProfile
    - name: EdgeActionVersions_CreateOrUpdate
    - name: EdgeActionVersions_Get
    - name: EdgeActionVersions_ListByEdgeAction
    - name: EdgeActionExecutionFilters_CreateOrUpdate
    - name: EdgeActionExecutionFilters_Get
    - name: EdgeActionExecutionFilters_ListByEdgeActionVersion
    - name: Operations_List
    - name: EdgeActionVersions_Update
    - name: EdgeActionExecutionFilters_Update
    - name: EdgeActions_Update
    - name: EdgeActionExecutionFilters_Delete
    - name: EdgeActionVersions_Delete
    - name: EdgeActions_Delete
```

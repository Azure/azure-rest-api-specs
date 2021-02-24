## CLI

These settings apply only when `--cli` is specified on the command line.

``` yaml $(cli)
cli:
  cli-name: capacity
  package-name: azure-mgmt-capacity
  namespace: azure.mgmt.capacity
  test-scenario:
    - name: Quotas_listUsagesForCompute
    - name: Quotas_Request_ForCompute
    - name: Quotas_Request_PatchForCompute
```

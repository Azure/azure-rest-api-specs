## CLI

These settings apply only when `--cli` is specified on the command line.

``` yaml $(cli)
cli:
  cli-name: reservations
  package-name: azure-mgmt-reservations
  namespace: azure.mgmt.reservations
  flatten-all: true
  test-scenario:
    - name: Quotas_listUsagesForCompute
    - name: Quotas_Request_ForCompute
    - name: Quotas_Request_PatchForCompute
    - name: Quotas_Request_PutForCompute
    - name: QuotaRequestStatus
    - name: QuotaRequestHistory      
```

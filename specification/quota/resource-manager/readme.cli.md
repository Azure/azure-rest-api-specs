## CLI

These settings apply only when `--cli` is specified on the command line.

``` yaml $(cli)
cli:
  cli-name: quota
  package-name: azure-mgmt-quota
  namespace: azure.mgmt.quota
  flatten-all: true
  test-scenario:
    - name: /Operation/get/GetOperations
      disabled: true
    - split: quota
    - name: /Quota/put/Quotas_Request_PutForCompute
    - name: /Quota/put/Quotas_Request_PutForMachineLearningServices_DedicatedResource
    - name: /Quota/put/Quotas_Request_PutForMachineLearningServices_LowPriorityResource
    - name: /Quota/get/Quotas_listUsagesForCompute
    - name: /Quota/get/Quotas_listUsagesMachineLearningServices
    - name: /Quota/get/Quotas_Request_ForCompute
    - name: /Quota/patch/Quotas_Request_PatchForCompute
    - split: quotaRequests
    - name: /QuotaRequestStatus/get/QuotaRequestFailed
      disabled: true
    - name: /QuotaRequestStatus/get/QuotaRequestHistory
    - name: /QuotaRequestStatus/get/QuotaRequestInProgress
      disabled: true
    - name: /QuotaRequestStatus/get/QuotaRequestStatus  
    - split: quotaProviders
    -name: /QuotaProviders/metadata/get/QuotaRPMetadata
```

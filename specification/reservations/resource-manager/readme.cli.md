## CLI

These settings apply only when `--cli` is specified on the command line.

``` yaml $(cli)
cli:
  cli-name: reservations
  package-name: azure-mgmt-reservations
  namespace: azure.mgmt.reservations
  flatten-all: true
  test-scenario:
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
    - split: exchange
    - name: /CalculateExchange/post/CalculateExchange
      disabled: true
    - name: /Exchange/post/Exchange
      disabled: true
    - name: /Operation/get/GetOperations
      disabled: true
    - name: /quota/get/AppliedReservationList
    - name: /quota/get/Catalog
    - split: reservations
    - name: /Reservation/get/GetReservation
    - name: /Reservation/get/ReservationList
    - name: /Reservation/get/ReservationRevisions
    - name: /Reservation/patch/PatchReservation
    - name: /Reservation/post/AvailableScopes
    - name: /Reservation/post/Merge
    - name: /Reservation/post/Split
    - name: /ReservationOrder/put/Purchase
    - name: /ReservationOrder/get/GetReservation
    - name: /ReservationOrder/get/GetReservationWithExpandPayments
    - name: /ReservationOrder/get/ReservationOrderList
    - name: /ReservationOrder/post/Purchase  
```

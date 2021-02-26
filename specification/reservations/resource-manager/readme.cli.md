## CLI

These settings apply only when `--cli` is specified on the command line.

``` yaml $(cli)
cli:
  cli-name: reservations
  package-name: azure-mgmt-reservations
  namespace: azure.mgmt.reservations
  flatten-all: true
  test-scenario:
    - name: /Quota/put/Quotas_Request_PutForCompute
    - name: /Quota/put/Quotas_Request_PutForMachineLearningServices_DedicatedResource
    - name: /Quota/put/Quotas_Request_PutForMachineLearningServices_LowPriorityResource
    - name: /Quota/get/Quotas_listUsagesForCompute
    - name: /Quota/get/Quotas_listUsagesMachineLearningServices
    - name: /Quota/get/Quotas_Request_ForCompute
    - name: /Quota/patch/Quotas_Request_PatchForCompute
    - name: /QuotaRequestStatus/get/QuotaRequestFailed
    - name: /QuotaRequestStatus/get/QuotaRequestHistory
    - name: /QuotaRequestStatus/get/QuotaRequestInProgress
    - name: /QuotaRequestStatus/get/QuotaRequestStatus  
    - name: /CalculateExchange/post/CalculateExchange
    - name: /Exchange/post/Exchange
    - name: /Operation/get/GetOperations
    - name: /quota/get/AppliedReservationList
    - name: /quota/get/Catalog
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

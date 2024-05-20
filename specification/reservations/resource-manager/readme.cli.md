## CLI

These settings apply only when `--cli` is specified on the command line.

``` yaml $(cli)
cli:
  cli-name: reservations
  package-name: azure-mgmt-reservations
  namespace: azure.mgmt.reservations
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
    - split: exchange
    - name: /CalculateExchange/post/CalculateExchange
      disabled: true
    - name: /Exchange/post/Exchange
      disabled: true
    - name: /quota/get/AppliedReservationList
    - name: /quota/get/Catalog
    - split: reservations
    - name: /Reservation/get/GetReservation
      disabled: true
    - name: /Reservation/get/ReservationList
      disabled: true    
    - name: /Reservation/get/ReservationRevisions
      disabled: true    
    - name: /Reservation/patch/PatchReservation
      disabled: true    
    - name: /Reservation/post/AvailableScopes
      disabled: true    
    - name: /Reservation/post/Merge
      disabled: true    
    - name: /Reservation/post/Split
      disabled: true    
    - name: /ReservationOrder/put/Purchase
      disabled: true    
    - name: /ReservationOrder/get/GetReservation
      disabled: true    
    - name: /ReservationOrder/get/GetReservationWithExpandPayments
      disabled: true    
    - name: /ReservationOrder/get/ReservationOrderList
      disabled: true    
    - name: /ReservationOrder/post/Purchase  
      disabled: true    
```

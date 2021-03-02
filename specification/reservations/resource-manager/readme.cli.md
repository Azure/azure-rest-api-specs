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
      disabled: true
    - name: /Quota/put/Quotas_Request_PutForMachineLearningServices_DedicatedResource
      disabled: true
    - name: /Quota/put/Quotas_Request_PutForMachineLearningServices_LowPriorityResource
      disabled: true
    - name: /Quota/get/Quotas_listUsagesForCompute
      disabled: true
    - name: /Quota/get/Quotas_listUsagesMachineLearningServices
      disabled: true
    - name: /Quota/get/Quotas_Request_ForCompute
      disabled: true
    - name: /Quota/patch/Quotas_Request_PatchForCompute
      disabled: true
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
      disabled: true
    - name: /quota/get/Catalog
      disabled: true
    - split: reservations
    - name: /Reservation/get/GetReservation
      disabled: true
    - name: /Reservation/get/ReservationList
      disabled: false    
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
      disabled: false
```

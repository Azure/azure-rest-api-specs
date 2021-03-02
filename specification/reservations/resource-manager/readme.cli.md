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
      disabled: false
    - name: /Quota/put/Quotas_Request_PutForMachineLearningServices_DedicatedResource
      disabled: false
    - name: /Quota/put/Quotas_Request_PutForMachineLearningServices_LowPriorityResource
      disabled: false
    - name: /Quota/get/Quotas_listUsagesForCompute
      disabled: false
    - name: /Quota/get/Quotas_listUsagesMachineLearningServices
      disabled: false
    - name: /Quota/get/Quotas_Request_ForCompute
      disabled: false
    - name: /Quota/patch/Quotas_Request_PatchForCompute
      disabled: false
    - split: quotaRequests
    - name: /QuotaRequestStatus/get/QuotaRequestFailed
      disabled: true
    - name: /QuotaRequestStatus/get/QuotaRequestHistory
    - name: /QuotaRequestStatus/get/QuotaRequestInProgress
      disabled: true
    - name: /QuotaRequestStatus/get/QuotaRequestStatus  
    - split: exchange
    - name: /CalculateExchange/post/CalculateExchange
      disabled: false
    - name: /Exchange/post/Exchange
      disabled: false
    - name: /quota/get/AppliedReservationList
      disabled: false
    - name: /quota/get/Catalog
      disabled: false
    - split: reservations
    - name: /Reservation/get/GetReservation
      disabled: false
    - name: /Reservation/get/ReservationList
      disabled: false    
    - name: /Reservation/get/ReservationRevisions
      disabled: false    
    - name: /Reservation/patch/PatchReservation
      disabled: false    
    - name: /Reservation/post/AvailableScopes
      disabled: false    
    - name: /Reservation/post/Merge
      disabled: false    
    - name: /Reservation/post/Split
      disabled: false    
    - name: /ReservationOrder/put/Purchase
      disabled: false    
    - name: /ReservationOrder/get/GetReservation
      disabled: false    
    - name: /ReservationOrder/get/GetReservationWithExpandPayments
      disabled: false    
    - name: /ReservationOrder/get/ReservationOrderList
      disabled: false    
    - name: /ReservationOrder/post/Purchase  
      disabled: false
```

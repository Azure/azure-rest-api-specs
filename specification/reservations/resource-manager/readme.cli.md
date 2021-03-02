## CLI

These settings apply only when `--cli` is specified on the command line.

``` yaml $(cli)
cli:
  cli-name: reservations
  package-name: azure-mgmt-reservations
  namespace: azure.mgmt.reservations
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
    - name: /QuotaRequestStatus/get/QuotaRequestInProgress
      disabled: true
    - name: /QuotaRequestStatus/get/QuotaRequestStatus  
    - name: /QuotaRequestStatus/get/QuotaRequestHistory
    - split: exchange
    - name: /CalculateExchange/post/CalculateExchange
      disabled: false
    - name: /Exchange/post/Exchange
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
    - split: ReservationOrder
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
    - name: /quota/get/AppliedReservationList
      disabled: false
    - name: /quota/get/Catalog
      disabled: false
```

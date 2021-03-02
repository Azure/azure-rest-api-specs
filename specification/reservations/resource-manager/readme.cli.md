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
     - split: Quotas  
     - name: /Quota/put/Quota_Request_Put_Compute
     - name: /Quota/put/Quota_Request_Put_MachineLearningServices_DedicatedResource
     - name: /Quota/put/Quota_Request_Put_MachineLearningServices_LowPriorityResource
     - name: /Quota/get/Quota_Info_Compute
     - name: /Quota/get/Quotas_List_Compute
     - name: /Quota/get/Quotas_List_MachineLearningServices
     - name: /Quota/patch/Quota_Request_Patch_Compute
     - split: QuotaRequestStatus
     - name: /QuotaRequestStatus/get/QuotaRequest_Failed
       disabled: true     
     - name: /QuotaRequestStatus/get/QuotaRequest_InProgress
       disabled: true          
     - name: /QuotaRequestStatus/get/QuotaRequest_History
     - name: /QuotaRequestStatus/get/QuotaRequest_Status
     - split: Reservation
     - name: /Reservation/get/GetReservation
     - name: /Reservation/get/ReservationList
     - name: /Reservation/get/ReservationRevisions
     - name: /Reservation/patch/PatchReservation
     - name: /Reservation/post/AvailableScopes
     - name: /Reservation/post/Merge
     - name: /Reservation/post/Split
     - name: /reservations/get/AppliedReservationList
     - name: /reservations/get/Catalog
     - name: /ReservationOrder/put/Purchase
     - name: /ReservationOrder/get/GetReservation
     - name: /ReservationOrder/get/GetReservationWithExpandPayments
     - name: /ReservationOrder/get/ReservationOrderList
     - name: /ReservationOrder/post/Purchase
     - name: /CalculateExchange/post/CalculateExchange
     - name: /Exchange/post/Exchange
```

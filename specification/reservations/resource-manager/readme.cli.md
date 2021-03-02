## CLI

These settings apply only when `--cli` is specified on the command line.

``` yaml $(cli)
cli:
  cli-name: reservations
  package-name: azure-mgmt-reservations
  namespace: azure.mgmt.reservations
  cli-directive:
    - select: 'operationGroup'
      where:
          operationGroup: 'operations'
      hidden: true
    - select: 'operationGroup' 
      where:
          operationGroup: 'quota_request_status'
        alias:
          - quotaStatus
          - status
          - s 
    - select: 'operationGroup'          
      where:
          operationGroup: 'quota'
        alias:
          - quota
          - q 
      - select: 'operationGroup'   
        where:
          operationGroup: 'quota'
          param: 'ResourceName'
        alias:
          - n
          - name
  test-scenario:
     - name: /Operation/get/GetOperations
     - split: quota 
     - name: /Quota/put/Quota_Request_Put_Compute
     - name: /Quota/put/Quota_Request_Put_MachineLearningServices_DedicatedResource
     - name: /Quota/put/Quota_Request_Put_MachineLearningServices_LowPriorityResource
     - name: /Quota/get/Quota_Info_Compute
     - name: /Quota/get/Quotas_List_Compute
     - name: /Quota/get/Quotas_List_MachineLearningServices
     - name: /Quota/patch/Quota_Request_Patch_Compute
     - split: quota_request_status
     - name: /QuotaRequestStatus/get/QuotaRequest_History
     - name: /QuotaRequestStatus/get/QuotaRequest_Status
     - name: /QuotaRequestStatus/get/QuotaRequest_Failed
       disabled: true     
     - name: /QuotaRequestStatus/get/QuotaRequest_InProgress
       disabled: true 
     - split: reservation
     - name: /Reservation/get/GetReservation
     - name: /Reservation/get/ReservationList
     - name: /Reservation/get/ReservationRevisions
     - name: /Reservation/patch/PatchReservation
     - name: /Reservation/post/AvailableScopes
     - name: /Reservation/post/Merge
     - name: /Reservation/post/Split
     - split: reservations
     - name: /reservations/get/AppliedReservationList
     - name: /reservations/get/Catalog
     - split: reservation_order
     - name: /ReservationOrder/put/Purchase
     - name: /ReservationOrder/get/GetReservation
     - name: /ReservationOrder/get/GetReservationWithExpandPayments
     - name: /ReservationOrder/get/ReservationOrderList
     - name: /ReservationOrder/post/Purchase
     - split: calculate_exchange
     - name: /CalculateExchange/post/CalculateExchange
     - split exchange
     - name: /Exchange/post/Exchange
```

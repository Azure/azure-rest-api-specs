## CLI

These settings apply only when `--cli` is specified on the command line.

``` yaml $(cli)
cli:
  cli-name: databox
  package-name: azure-mgmt-databox
  namespace: azure.mgmt.databox
  test-scenario:
    - name: JobsCreate
    - name: JobsGet6
    - name: JobsGet5
    - name: JobsGet4
    - name: JobsGet3
    - name: JobsGet2
    - name: JobsGet1
    - name: JobsGet
    - name: JobsListByResourceGroup
    - name: JobsList
    - name: OperationsGet
    - name: ServiceValidateInputsByResourceGroup
    - name: AvailableSkusByResourceGroup
    - name: BookShipmentPickupPost
    - name: JobsListCredentials
    - name: JobsCancelPost
    - name: JobsPatch
    - name: ServiceRegionConfiguration
    - name: ValidateAddressPost
    - name: ServiceValidateInputs
    - name: AvailableSkusPost
    - name: JobsDelete
    - name: JobMitigate
    - name: JobsGetWaitingForAction
    - name: MarkDevicesShipped
```
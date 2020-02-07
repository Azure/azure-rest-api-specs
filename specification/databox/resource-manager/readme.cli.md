## CLI

These settings apply only when `--cli` is specified on the command line.

``` yaml $(cli)
cli:
  cli-name: databox
  package-name: azure-mgmt-databox
  namespace: azure.mgmt.databox
  test-scenario:
    - name: JobsCreate
    - name: JobsGet4
    - name: JobsGet3
    - name: JobsGet2
    - name: JobsGet1
    - name: JobsGet
    - name: JobsGet5
    - name: JobsListByResourceGroup
    - name: JobsList
    - name: OperationsGet
    - name: BookShipmentPickupPost
    - name: JobsListCredentials
    - name: JobsCancelPost
    - name: JobsPatch
    - name: ValidateAddressPost
    - name: AvailableSkusPost
    - name: JobsDelete
```
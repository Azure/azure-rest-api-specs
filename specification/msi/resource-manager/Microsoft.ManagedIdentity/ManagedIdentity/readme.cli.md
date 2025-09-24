## CLI

These settings don't need to apply `--cli` on the command line.

``` yaml
cli:
  cli-name: msi
  package-name: azure-mgmt-msi
  namespace: azure.mgmt.msi
  test-scenario:
    - name: IdentityCreate
    - name: IdentityGet
    - name: IdentityListByResourceGroup
    - name: IdentityListBySubscription
    - name: MsiOperationsList
    - name: MsiOperationsList
    - name: IdentityUpdate
    - name: IdentityDelete
```
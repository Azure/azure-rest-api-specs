## CLI

These settings apply only when `--cli` is specified on the command line.
current tag-package=2018-05
``` yaml $(cli)
cli:
  cli-name: maps
  package-name: azure-mgmt-maps
  namespace: azure.mgmt.maps
  test-scenario:
    - name: CreateAccount
    - name: GetAccount
    - name: ListAccountsByResourceGroup
    - name: ListAccountsBySubscription
    - name: GetOperations
    - name: RegenerateKey
    - name: ListKeys
    - name: UpdateAccount
    - name: MoveAccounts
    - name: DeleteAccount
```
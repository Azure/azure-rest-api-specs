## CLI

These settings apply only when `--cli` is specified on the command line.

``` yaml $(cli)
cli:
  cli-name: confidentialledger
  package-name: azure-mgmt-confidentialledger
  namespace: azure.mgmt.confidentialledger
  test-scenario:
    - name: LedgerCreate
    - name: LedgerDelete
    - name: LedgerUpdate
    - name: LedgerGet
    - name: ListLedgers
    - name: ListLedgersInSubscription
```

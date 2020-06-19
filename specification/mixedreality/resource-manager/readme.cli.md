## CLI

These settings apply only when `--cli` is specified on the command line.

``` yaml $(cli)
cli:
  cli-name: mixed-reality
  package-name: azure-mgmt-mixedreality
  namespace: azure.mgmt.mixedreality
  test-scenario:
    - name: Create spatial anchor account
    - name: Create remote rendering account
    - name: Get remote rendering account key
    - name: Get spatial anchor account key
    - name: List spatial anchor accounts by resource group
    - name: List remote rendering accounts by resource group
    - name: Get spatial anchors account
    - name: Get remote rendering account
    - name: List remote rendering accounts by subscription
    - name: List spatial anchors accounts by subscription
    - name: List available operations
      disabled: true
    - name: Regenerate remote rendering account keys
    - name: Regenerate spatial anchors account keys
    - name: Update remote rendering account
      disabled: true
    - name: Update spatial anchors account
      disabled: true
    - name: CheckLocalNameAvailability
      disabled: true
    - name: Delete spatial anchors account
    - name: Delete remote rendering account
```

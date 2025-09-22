## CLI

These settings apply only when `--cli` is specified on the command line.

``` yaml $(cli)
cli:
  cli-name: mixed-reality
  package-name: azure-mgmt-mixedreality
  namespace: azure.mgmt.mixedreality
  test-scenario:
    - name: Create remote rendering account
    - name: Get remote rendering account key
    - name: List remote rendering accounts by resource group
    - name: Get remote rendering account
    - name: List remote rendering accounts by subscription
    - name: List available operations
      disabled: true
    - name: Regenerate remote rendering account keys
    - name: Update remote rendering account
      disabled: true
    - name: CheckLocalNameAvailability
      disabled: true
    - name: Delete remote rendering account
  cli-directive:
    - where:
        operation: CheckNameAvailabilityLocal
      hidden: true
```

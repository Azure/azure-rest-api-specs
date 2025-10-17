## CLI

These settings apply only when `--cli` is specified on the command line.

``` yaml $(cli)
cli:
  cli-name: mixed-reality
  package-name: azure-mgmt-mixedreality
  namespace: azure.mgmt.mixedreality
  test-scenario:
    - name: List available operations
      disabled: true
      disabled: true
    - name: CheckLocalNameAvailability
      disabled: true
  cli-directive:
    - where:
        operation: CheckNameAvailabilityLocal
      hidden: true
```

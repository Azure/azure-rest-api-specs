## CLI

These settings don't need to apply `--cli` on the command line.

``` yaml $(cli)
cli:
  cli-name: mobility
  test-scenario:
    - name: MCVPAccountCheckNameAvailability
    - name: MCVPAccountGetProperties
    - name: MCVPAccountListBySubscription
    - name: MCVPAccountListByResourceGroup
```
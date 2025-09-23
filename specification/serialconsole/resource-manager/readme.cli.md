## CLI

These settings apply only when `--cli` is specified on the command line.

``` yaml $(cli)
cli:
  cli-name: serialconsole
  package-name: azure-mgmt-serialconsole
  namespace: azure.mgmt.serialconsole
  test-scenario:
    - name: Get the Serial Console disabled status for a subscription
    - name: List all Serial Console management operations supported by Serial Console RP
    - name: Disable Serial Console for a subscription
    - name: Enable Serial Console for a subscription
```
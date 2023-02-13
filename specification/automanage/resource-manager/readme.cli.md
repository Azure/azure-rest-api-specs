## CLI

These settings don't need to apply `--cli` on the command line.

``` yaml
cli:
  cli-name: automanage
  package-name: azure-mgmt-automanage
  namespace: azure.mgmt.automanage
  test-scenario:
    - name: Create or update configuration profile assignment
    - name: Delete a configuration profile assignment
    - name: Get a configuration profile assignment
    - name: Lists configuration profile assignment
    - name: Operations
```
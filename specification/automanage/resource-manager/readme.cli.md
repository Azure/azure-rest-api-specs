## CLI

These settings don't need to apply `--cli` on the command line.

``` yaml
cli:
  cli-name: automanage
  package-name: azure-mgmt-automanage
  namespace: azure.mgmt.automanage
  test-scenario:
    - name: Create or update an Automanage account
    - name: Create or update configuration profile assignment
    - name: Create or update configuration profile preference
    - name: Delete an Automanage account
    - name: Delete a configuration profile assignment
    - name: Delete a configuration profile preference
    - name: Get an Automanage account
    - name: Get a configuration profile assignment
    - name: Get a configuration profile preference
    - name: Lists Automanage account
    - name: Lists configuration profile assignment
    - name: Lists configuration profile preference
    - name: Operations
```
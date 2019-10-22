## CLI

These settings apply only when `--cli` is specified on the command line.

``` yaml $(cli)
cli:
  cli-name: managednetwork
  namespace: azure.mgmt.managednetwork
  package-name: azure-mgmt-managednetwork
  debug: true
  cmd-override:
    "^.*[/]microsoft.managednetwork/scopeassignments([/][^/]*)?$": "managednetwork scope-assignment"
  flatten-all: true
  test-setup:
    - name: Create or Update a service with all parameters
```

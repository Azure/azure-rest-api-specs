## CLI

These settings apply only when `--cli` is specified on the command line.

``` yaml $(cli)
cli:
  namespace: azure.mgmt.smartgroups
  test-scenario:
    - name: /SmartGroups/get/Resolve
    - name: /SmartGroups/get/List
    - name: /SmartGroups/get/Get
    - name: /SmartGroups/post/changestate
```

## CLI

These settings apply only when `--cli` is specified on the command line.

``` yaml $(cli)
cli:
  cli-name: mixed-reality
  package-name: azure-mgmt-mixedreality
  namespace: azure.mgmt.mixedreality
  test-scenario:
    - name: /SpatialAnchorsAccounts/put/Create spatial anchor account
    - name: /RemoteRenderingAccounts/put/Create remote rendering account
    - name: /RemoteRenderingAccounts/get/Get remote rendering account key
    - name: /SpatialAnchorsAccounts/get/Get spatial anchor account key
    - name: /RemoteRenderingAccounts/get/Get remote rendering account
    - name: /SpatialAnchorsAccounts/get/Get spatial anchors account
    - name: /RemoteRenderingAccounts/get/List remote rendering accounts by resource group
    - name: /SpatialAnchorsAccounts/get/List spatial anchor accounts by resource group
    - name: /RemoteRenderingAccounts/get/List remote rendering accounts by subscription
    - name: /SpatialAnchorsAccounts/get/List spatial anchors accounts by subscription
    - name: /Operations/get/List available operations
    - name: /RemoteRenderingAccounts/post/Regenerate remote rendering account keys
    - name: /SpatialAnchorsAccounts/post/Regenerate spatial anchors account keys
    - name: /RemoteRenderingAccounts/patch/Update remote rendering account
    - name: /SpatialAnchorsAccounts/patch/Update spatial anchors account
    - name: //post/CheckLocalNameAvailability
    - name: /RemoteRenderingAccounts/delete/Delete remote rendering account
    - name: /SpatialAnchorsAccounts/delete/Delete spatial anchors account
```

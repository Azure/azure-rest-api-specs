## CLI

These settings don't need to apply `--cli` on the command line.

``` yaml
cli:
  cli-name: containerinstance
  package-name: azure-mgmt-containerinstance
  namespace: azure.mgmt.containerinstance
  test-scenario:
    - name: /ContainerGroups/put/ContainerGroupsCreateOrUpdate
      disabled: true
    - name: /ContainerGroups/put/ContainerGroupsCreateOrUpdateSample
    - name: /Containers/get/ContainerListLogs
    - name: /ContainerGroups/get/ContainerGroupsGet_Failed
    - name: /ContainerGroups/get/ContainerGroupsGet_Succeeded
    - name: /ContainerGroups/get/ContainerGroupsListByResourceGroup
    - name: /Location/get/CachedImages
    - name: /Location/get/GetCapabilities
    - name: /Location/get/ContainerUsage
    - name: /ContainerGroups/get/ContainerGroupsList
    - name: /Operations/get/OperationsList
    - name: /Containers/post/ContainerExec
    - name: /ContainerGroups/post/ContainerRestart
    - name: /ContainerGroups/post/ContainerStart
    - name: /ContainerGroups/post/ContainerStop
    - name: /ContainerGroups/patch/ContainerGroupsUpdate
    - name: /ContainerGroups/delete/ContainerGroupsDelete
```

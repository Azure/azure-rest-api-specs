## CLI

These settings apply only when `--cli` is specified on the command line.

``` yaml $(cli)
cli:
  cli-name: storageimportexport
  namespace: azure.mgmt.storageimportexport
  package-name: azure-mgmt-storageimportexport
  test-scenario:
    - name: /Jobs/put/Create job
    - name: /Jobs/get/Get job
    - name: /Locations/get/Get locations
    - name: /BitLockerKeys/post/List BitLocker Keys for drives in a job
    - name: /Jobs/get/List jobs in a resource group
    - name: /Jobs/get/List jobs in a subscription
    - name: /Locations/get/List locations
    - name: /Jobs/patch/Update job
    - name: /Jobs/delete/Delete job
```

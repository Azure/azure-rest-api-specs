## Azure CLI

These settings apply only when `--az` is specified on the command line.

``` yaml $(az)
az:
  extensions: storageimportexport
  package-name: azure-mgmt-storageimportexport
  namespace: azure.mgmt.storageimportexport
python-sdk-output-folder: "$(output-folder)/src/storageimportexport/azext_storageimportexport/vendored_sdks/storageimportexport"
cli:
  cli-directive:
    - where:          
        type: 'PutJobParameters'
        prop: 'properties'
      flatten: true
```

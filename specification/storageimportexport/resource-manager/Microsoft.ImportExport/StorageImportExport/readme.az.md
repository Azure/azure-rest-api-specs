## Azure CLI

These settings apply only when `--az` is specified on the command line.

``` yaml $(az)
az:
  extensions: storageimportexport
  package-name: azure-mgmt-storageimportexport
  namespace: azure.mgmt.storageimportexport
az-output-folder: $(azure-cli-extension-folder)/src/storageimportexport
python-sdk-output-folder: "$(az-output-folder)/azext_storageimportexport/vendored_sdks/storageimportexport"
cli:
  cli-directive:
    - where:          
        type: 'PutJobParameters'
        prop: 'properties'
      flatten: true
```

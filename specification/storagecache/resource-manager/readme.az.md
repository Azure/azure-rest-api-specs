## AZ

These settings apply only when `--az` is specified on the command line.

``` yaml $(az)
az:
  extensions: storagecache
  namespace: azure.mgmt.storagecache
  package-name: azure-mgmt-storagecache
python-sdk-output-folder: "$(output-folder)/src/storagecache/azext_storagecache/vendored_sdks/storagecache"
  
#cli:
#    cli-directive:
#      directive on operationGroup
#       - select: 'operationGroup'
#         where:
#             operationGroup: 'operations'
#         hidden: true
#       - where:
#             parameter: location
#         required: true

```

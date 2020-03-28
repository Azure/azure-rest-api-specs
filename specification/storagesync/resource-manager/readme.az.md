## AZ

These settings apply only when `--az` is specified on the command line.

``` yaml $(az)
az:
  extensions: storagesync
  namespace: azure.mgmt.storagesync
  package-name: azure-mgmt-storagesync
python-sdk-output-folder: "$(output-folder)/src/storagesync/azext_storagesync/vendored_sdks/storagesync"
  
#cli:
#    cli-directive:
#      directive on operationGroup
#       - select: 'operationGroup'
#         where:
#             operationGroup: 'operations'
#         hidden: true
#       - where:
#             parameter: 'old_parameter_name'
#         required: true
#         name: 'new_name'

```

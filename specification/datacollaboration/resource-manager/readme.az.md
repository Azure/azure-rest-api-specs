## AZ

These settings apply only when `--az` is specified on the command line.

``` yaml $(az)
az:
  extensions: datacollaboration
  namespace: azure.mgmt.datacollaboration
  package-name: azure-mgmt-datacollaboration
az-output-folder: $(azure-cli-extension-folder)/src/datacollaboration
python-sdk-output-folder: "$(az-output-folder)/azext_datacollaboration/vendored_sdks/datacollaboration"
  
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

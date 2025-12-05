## AZ

These settings apply only when `--az` is specified on the command line.

``` yaml $(az)
az:
  extensions: portal
  namespace: azure.mgmt.portal
  package-name: azure-mgmt-portal
az-output-folder: $(azure-cli-extension-folder)/src/portal
python-sdk-output-folder: "$(az-output-folder)/azext_portal/vendored_sdks/portal"
  
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

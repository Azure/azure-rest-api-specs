## AZ

These settings apply only when `--az` is specified on the command line.

``` yaml $(az)
az:
  extensions: portal
  namespace: azure.mgmt.portal
  package-name: azure-mgmt-portal
python-sdk-output-folder: "$(output-folder)/src/portal/azext_portal/vendored_sdks/portal"
  
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

## AZ

These settings apply only when `--az` is specified on the command line.

``` yaml $(az)
az:
  extensions: operationsmanagement
  namespace: azure.mgmt.operationsmanagement
  package-name: azure-mgmt-operationsmanagement
python-sdk-output-folder: "$(output-folder)/src/operationsmanagement/azext_operationsmanagement/vendored_sdks/operationsmanagement"
  
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

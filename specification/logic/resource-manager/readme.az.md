## AZ

These settings apply only when `--az` is specified on the command line.

``` yaml $(az)
az:
  extensions: logic
  namespace: azure.mgmt.logic
  package-name: azure-mgmt-logic
python-sdk-output-folder: "$(output-folder)/src/logic/azext_logic/vendored_sdks/logic"
  
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

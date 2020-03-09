## AZ

These settings apply only when `--az` is specified on the command line.

``` yaml $(az)
az:
  extensions: customproviders
  namespace: azure.mgmt.customproviders
  package-name: azure-mgmt-customproviders
python-sdk-output-folder: "$(output-folder)/src/customproviders/azext_customproviders/vendored_sdks/customproviders"
  
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

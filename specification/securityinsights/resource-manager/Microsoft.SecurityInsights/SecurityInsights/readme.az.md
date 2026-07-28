## AZ

These settings apply only when `--az` is specified on the command line.

``` yaml $(az)
az:
  extensions: sentinel
  namespace: azure.mgmt.securityinsight
  package-name: azure-mgmt-securityinsight
az-output-folder: $(azure-cli-extension-folder)/src/securityinsight
python-sdk-output-folder: "$(az-output-folder)/azext_sentinel/vendored_sdks/securityinsight"
  
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

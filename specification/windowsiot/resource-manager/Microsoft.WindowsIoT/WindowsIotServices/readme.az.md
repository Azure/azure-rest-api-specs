## AZ

These settings apply only when `--az` is specified on the command line.

``` yaml $(az)
az:
  extensions: windowsiotservices
  namespace: azure.mgmt.windowsiot
  package-name: azure-mgmt-windowsiot
az-output-folder: $(azure-cli-extension-folder)/src/windowsiot
python-sdk-output-folder: "$(az-output-folder)/azext_windowsiotservices/vendored_sdks/windowsiot"
  
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

## AZ

These settings apply only when `--az` is specified on the command line.

``` yaml $(az)
az:
  extensions: devops
  namespace: azure.mgmt.devops
  package-name: azure-mgmt-devops
az-output-folder: $(azure-cli-extension-folder)/src/devops
python-sdk-output-folder: "$(az-output-folder)/azext_devops/vendored_sdks/devops"
  
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

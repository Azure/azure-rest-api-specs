## AZ

These settings apply only when `--az` is specified on the command line.

``` yaml $(az)
tag: package-2021-03-25-preview
az:
  extensions: m365securityandcompliance
  namespace: azure.mgmt.m365securityandcompliance
  package-name: azure-mgmt-m365securityandcompliance
az-output-folder: $(azure-cli-extension-folder)/src/m365securityandcompliance
python-sdk-output-folder: $(az-output-folder)/azext_m365securityandcompliance/vendored_sdks/m365securityandcompliance
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
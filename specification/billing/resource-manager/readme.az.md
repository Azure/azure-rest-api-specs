## AZ
These settings apply only when `--az` is specified on the command line.
``` yaml $(az) && $(target-mode) != 'core'
az:
  extensions: billing
  namespace: azure.mgmt.billing
  package-name: azure-mgmt-billing
az-output-folder: $(azure-cli-extension-folder)/src/billing
python-sdk-output-folder: "$(az-output-folder)/azext_billing/vendored_sdks/billing"
#cli:
#    cli-directive:
#      - where:
#            group: MachineLearningCompute
#            op: CreateOrUpdate
#            param: properties
#        poly-resource: true
```
``` yaml $(az) && $(target-mode) == 'core'
az:
  extensions: billing
  namespace: azure.mgmt.billing
  package-name: azure-mgmt-billing
az-output-folder: $(azure-cli-folder)/src/azure-cli/azure/cli/command_modules/billing
python-sdk-output-folder: "$(az-output-folder)/vendored_sdks/billing"
```

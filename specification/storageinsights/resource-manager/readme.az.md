## AZ

These settings apply only when `--az` is specified on the command line.

``` yaml $(az) && $(target-mode) != 'core'
az:
  extensions: storageinsights
  namespace: azure.mgmt.storageinsights
  package-name: azure-mgmt-storageinsights
az-output-folder: $(azure-cli-extension-folder)/src/storageinsights
python-sdk-output-folder: "$(az-output-folder)/azext_storageinsights/vendored_sdks/storageinsights"
```

<!-- Use this once onboarded to the azure cli main repo.
``` yaml $(az) && $(target-mode) == 'core'
az:
  extensions: storageinsights
  namespace: azure.mgmt.storageinsights
  package-name: azure-mgmt-storageinsights
az-output-folder: $(azure-cli-folder)/src/azure-cli/azure/cli/command_modules/storageinsights
python-sdk-output-folder: "$(az-output-folder)/vendored_sdks/storageinsights"
```  -->

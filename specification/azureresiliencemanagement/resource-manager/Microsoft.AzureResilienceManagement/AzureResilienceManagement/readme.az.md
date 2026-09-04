## AZ

These settings apply only when `--az` is specified on the command line.

``` yaml $(az)
az:
  extensions: azure-resilience-management
  namespace: azure.mgmt.azureresiliencemanagement
  package-name: azure-mgmt-azureresiliencemanagement
az-output-folder: $(azure-cli-extension-folder)/src/azure-resilience-management
python-sdk-output-folder: "$(az-output-folder)/azext_azure_resilience_management/vendored_sdks/azureresiliencemanagement"
```

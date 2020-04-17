## AZ

These settings apply only when `--az` is specified on the command line.

``` yaml $(az)
az:
  extensions: automation
  namespace: azure.mgmt.automation
  package-name: azure-mgmt-automation
az-output-folder: $(azure-cli-extension-folder)/src/automation
python-sdk-output-folder: "$(az-output-folder)/azext_automation/vendored_sdks/automation"


```

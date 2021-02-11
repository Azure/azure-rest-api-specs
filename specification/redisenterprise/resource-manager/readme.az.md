## AZ

These settings apply only when `--az` is specified on the command line.

``` yaml $(az) && $(target-mode) != 'core'
az:
    extensions: redisenterprise
    namespace: azure.mgmt.redisenterprise
    package-name: azure-mgmt-redisenterprise
az-output-folder: $(azure-cli-extension-folder)/src/redisenterprise
python-sdk-output-folder: "$(az-output-folder)/azext_redisenterprise/vendored_sdks/redisenterprise"
# add additional configuration here specific for Azure CLI
# refer to the faq.md for more details
```
``` yaml $(az) && $(target-mode) == 'core'
az:
    extensions: redisenterprise
    namespace: azure.mgmt.redisenterprise
    package-name: azure-mgmt-redisenterprise
az-output-folder: $(azure-cli-folder)/src/azure-cli/azure/cli/command_modules/redisenterprise
python-sdk-output-folder: "$(az-output-folder)/vendored_sdks/redisenterprise"
# add additional configuration here specific for Azure CLI
# refer to the faq.md for more details
```
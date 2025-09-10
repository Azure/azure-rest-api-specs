## AZ

These settings apply only when `--az` is specified on the command line.

For new Resource Provider. It is highly recommended to onboard Azure CLI extensions. There's no differences in terms of customer usage. 

``` yaml $(az) && $(target-mode) != 'core'
az:
    extensions: updatemanager
    namespace: azure.mgmt.updatemanager
    package-name: azure-mgmt-updatemanager
az-output-folder: $(azure-cli-extension-folder)/src/updatemanager
python-sdk-output-folder: "$(az-output-folder)/azext_updatemanager/vendored_sdks/updatemanager"
# add additional configuration here specific for Azure CLI
# refer to the faq.md for more details
```

## AZ

These settings apply only when `--az` is specified on the command line.

``` yaml $(az) && $(target-mode) != 'core'
az:
    extensions: devcenter
    namespace: azure.mgmt.devcenter
    package-name: azure-mgmt-devcenter
az-output-folder: $(azure-cli-extension-folder)/src/devcenter
python-sdk-output-folder: "$(az-output-folder)/azext_devcenter/vendored_sdks/devcenter"
# add additional configuration here specific for Azure CLI
# refer to the faq.md for more details
```

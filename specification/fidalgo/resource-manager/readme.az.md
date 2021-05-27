## AZ

These settings apply only when `--az` is specified on the command line.

``` yaml $(az) && $(target-mode) != 'core'
az:
    extensions: fidalgo
    namespace: azure.mgmt.fidalgo
    package-name: azure-mgmt-fidalgo
az-output-folder: $(azure-cli-extension-folder)/src/fidalgo
python-sdk-output-folder: "$(az-output-folder)/azext_fidalgo/vendored_sdks/fidalgo"
# add additional configuration here specific for Azure CLI
# refer to the faq.md for more details
```

## AZ

These settings apply only when `--az` is specified on the command line.

``` yaml $(az) && $(target-mode) != 'core'
az:
    extensions: cpim
    namespace: azure.mgmt.cpim
    package-name: azure-mgmt-cpim
az-output-folder: $(azure-cli-extension-folder)/src/cpim
python-sdk-output-folder: "$(az-output-folder)/azext_cpim/vendored_sdks/cpim"
# add additinal configuration here specific for Azure CLI
# refer to the faq.md for more details
```
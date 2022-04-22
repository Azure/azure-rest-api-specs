## AZ

These settings apply only when `--az` is specified on the command line.

``` yaml $(az) && $(target-mode) != 'core'
az:
    extensions: dnc
    namespace: azure.mgmt.dnc
    package-name: azure-mgmt-dnc
az-output-folder: $(azure-cli-extension-folder)/src/dnc
python-sdk-output-folder: "$(az-output-folder)/azext_dnc/vendored_sdks/dnc"
# add additinal configuration here specific for Azure CLI
# refer to the faq.md for more details
extension-mode: preview
```
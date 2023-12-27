## AZ

These settings apply only when `--az` is specified on the command line.

``` yaml $(az)
az:
    extensions: edgemarketplace
    namespace: azure.mgmt.edgemarketplace
    package-name: azure-mgmt-edgemarketplace
az-output-folder: $(azure-cli-extension-folder)/src/edgemarketplace
python-sdk-output-folder: "$(az-output-folder)/azext_edgemarketplace/vendored_sdks/edgemarketplace"
# add additional configuration here specific for Azure CLI
# refer to the faq.md for more details
```

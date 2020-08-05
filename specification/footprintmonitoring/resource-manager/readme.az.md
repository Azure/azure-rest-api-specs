## AZ

These settings apply only when `--az` is specified on the command line.

``` yaml $(az)
az:
    extensions: footprint
    namespace: azure.mgmt.footprint
    package-name: azure-mgmt-footprint
    randomize-names: true
az-output-folder: $(azure-cli-extension-folder)/src/footprint
python-sdk-output-folder: "$(az-output-folder)/azext_footprint/vendored_sdks/footprint"
# add additinal configuration here specific for Azure CLI
# refer to the faq.md for more details
```
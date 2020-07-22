## AZ

These settings apply only when `--az` is specified on the command line.

``` yaml $(az)
az:
    extensions: footprintmonitoring
    namespace: azure.mgmt.footprintmonitoring
    package-name: azure-mgmt-footprintmonitoring
az-output-folder: $(azure-cli-extension-folder)/src/footprintmonitoring
python-sdk-output-folder: "$(az-output-folder)/azext_footprintmonitoring/vendored_sdks/footprintmonitoring"
# add additinal configuration here specific for Azure CLI
# refer to the faq.md for more details
```
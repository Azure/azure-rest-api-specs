## AZ

These settings apply only when `--az` is specified on the command line.

``` yaml $(az)
az:
    extensions: providerhub
    namespace: azure.mgmt.providerhub
    package-name: azure-mgmt-providerhub
az-output-folder: $(azure-cli-extension-folder)/src/providerhub
python-sdk-output-folder: "$(az-output-folder)/azext_providerhub/vendored_sdks/providerhub"
# add additional configuration here specific for Azure CLI
# refer to the faq.md for more details

## AZ

These settings apply only when `--az` is specified on the command line.

``` yaml $(az)
az:
    extensions: artifactsigning
    namespace: azure.mgmt.artifactsigning
    package-name: azure-mgmt-artifactsigning
    randomize-names: true
az-output-folder: $(azure-cli-extension-folder)/src/artifactsigning
python-sdk-output-folder: "$(az-output-folder)/azext_artifactsigning/vendored_sdks/artifactsigning"
# add additional configuration here specific for Azure CLI
# refer to the faq.md for more details


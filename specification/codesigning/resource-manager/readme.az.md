## AZ

These settings apply only when `--az` is specified on the command line.

``` yaml $(az)
az:
    extensions: trustedsigning
    namespace: azure.mgmt.trustedsigning
    package-name: azure-mgmt-trustedsigning
    randomize-names: true
az-output-folder: $(azure-cli-extension-folder)/src/trustedsigning
python-sdk-output-folder: "$(az-output-folder)/azext_trustedsigning/vendored_sdks/trustedsigning"
# add additional configuration here specific for Azure CLI
# refer to the faq.md for more details


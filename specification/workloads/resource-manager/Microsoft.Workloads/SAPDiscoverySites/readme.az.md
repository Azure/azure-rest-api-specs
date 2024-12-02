## AZ

These settings apply only when `--az` is specified on the command line.

For new Resource Provider. It is highly recommended to onboard Azure CLI extensions. There's no differences in terms of customer usage. 

``` yaml $(az) && $(target-mode) != 'core'
az:
    extensions: migrationdiscoverysap
    namespace: azure.mgmt.migrationdiscoverysap
    package-name: azure-mgmt-migrationdiscoverysap
az-output-folder: $(azure-cli-extension-folder)/src/migrationdiscovery/migrationdiscoverysap
python-sdk-output-folder: "$(az-output-folder)/azext_migrationdiscovery/vendored_sdks/migrationdiscovery/migrationdiscoverysap"
# add additional configuration here specific for Azure CLI
# refer to the faq.md for more details
```
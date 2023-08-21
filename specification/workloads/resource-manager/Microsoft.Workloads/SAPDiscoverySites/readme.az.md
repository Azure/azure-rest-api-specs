## AZ

These settings apply only when `--az` is specified on the command line.

For new Resource Provider. It is highly recommended to onboard Azure CLI extensions. There's no differences in terms of customer usage. 

``` yaml $(az) && $(target-mode) != 'core'
az:
    extensions: sapdiscoverysite
    namespace: azure.mgmt.workloads.sapdiscoverysite
    package-name: azure-mgmt-workloads-sapdiscoverysite
az-output-folder: $(azure-cli-extension-folder)/src/workloads/sapdiscoverysite
python-sdk-output-folder: "$(az-output-folder)/azext_workloads/vendored_sdks/workloads/sapdiscoverysite"
# add additional configuration here specific for Azure CLI
# refer to the faq.md for more details
```
## AZ

These settings apply only when `--az` is specified on the command line.

For new Resource Provider. It is highly recommended to onboard Azure CLI extensions. There's no differences in terms of customer usage. 

``` yaml $(az) && $(target-mode) != 'core'
az:
    extensions: workloads
    namespace: azure.mgmt.workloads
    package-name: azure-mgmt-workloads
az-output-folder: $(azure-cli-extension-folder)/src/workloads
python-sdk-output-folder: "$(az-output-folder)/azext_workloads/vendored_sdks/workloads"
# add additional configuration here specific for Azure CLI
# refer to the faq.md for more details
```
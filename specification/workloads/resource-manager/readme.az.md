## AZ

These settings apply only when `--az` is specified on the command line.

``` yaml $(az)
az:
    extensions: workloads
    namespace: azure.mgmt.workloads
    package-name: azure-mgmt-workloads
az-output-folder: $(azure-cli-extension-folder)/src/workloads
python-sdk-output-folder: "$(az-output-folder)/azext_workloads/vendored_sdks/workloads"
# add additinal configuration here specific for Azure CLI
# refer to the faq.md for more details
```
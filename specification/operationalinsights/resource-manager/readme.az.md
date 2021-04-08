## AZ

These settings apply only when `--az` is specified on the command line.

For new Resource Provider. It is highly recommended to onboard Azure CLI extensions. There's no differences in terms of customer usage. 

``` yaml $(az)
az:
    extensions: OperationalInsights
    namespace: azure.mgmt.loganalytics
    package-name: azure-mgmt-loganalytics
az-output-folder: $(azure-cli-extension-folder)/src/operationalinsights
python-sdk-output-folder: "$(az-output-folder)/azext_operationalinsights/vendored_sdks/operationalinsights"
# add additional configuration here specific for Azure CLI
# refer to the faq.md for more details
```

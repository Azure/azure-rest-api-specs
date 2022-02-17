## AZ

These settings apply only when `--az` is specified on the command line.

For new Resource Provider. It is highly recommended to onboard Azure CLI extensions. There's no differences in terms of customer usage. 

``` yaml $(az) && $(target-mode) != 'core'
az:
    extensions: loganalytics
    namespace: azure.mgmt.loganalytics
    package-name: azure-mgmt-loganalytics
az-output-folder: $(azure-cli-extension-folder)/src/loganalytics
python-sdk-output-folder: "$(az-output-folder)/azext_loganalytics/vendored_sdks/loganalytics"
# add additional configuration here specific for Azure CLI
# refer to the faq.md for more details
```
``` yaml $(az) && $(target-mode) == 'core'
az:
    extensions: loganalytics
    namespace: azure.mgmt.loganalytics
    package-name: azure-mgmt-loganalytics
az-output-folder: $(azure-cli-folder)/src/azure-cli/azure/cli/command_modules/loganalytics
python-sdk-output-folder: "$(az-output-folder)/azext_loganalytics/vendored_sdks/loganalytics"
# add additinal configuration here specific for Azure CLI
# refer to the faq.md for more details
```

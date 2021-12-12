// file: readme.az.md

## AZ

These settings apply only when `--az` is specified on the command line.

``` yaml $(az) && $(target-mode) != 'core'
az:
    extensions: alertsmanagement
    namespace: azure.mgmt.alertsmanagement
    package-name: azure-mgmt-alertsmanagement
az-output-folder: $(azure-cli-extension-folder)/src/alertsmanagement
python-sdk-output-folder: "$(az-output-folder)/azext_alertsmanagement/vendored_sdks/alertsmanagement"
# add additional configuration here specific for Azure CLI
# refer to the faq.md for more details
```
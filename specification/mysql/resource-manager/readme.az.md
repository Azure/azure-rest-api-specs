## AZ

These settings apply only when `--az` is specified on the command line.

``` yaml $(az)
az:
    extensions: mysql
    namespace: azure.mgmt.mysql
    package-name: azure-mgmt-mysql
az-output-folder: $(azure-cli-extension-folder)/src/mysql
python-sdk-output-folder: "$(az-output-folder)/azext_mysql/vendored_sdks/mysql"
# add additinal configuration here specific for Azure CLI
# refer to the faq.md for more details
```
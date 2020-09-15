## AZ

These settings apply only when `--az` is specified on the command line.

``` yaml $(az)
az:
    extensions: postgresql
    namespace: azure.mgmt.postgresql
    package-name: azure-mgmt-postgresql
az-output-folder: $(azure-cli-extension-folder)/src/postgresql
python-sdk-output-folder: "$(az-output-folder)/azext_postgresql/vendored_sdks/postgresql"
# add additinal configuration here specific for Azure CLI
# refer to the faq.md for more details
```
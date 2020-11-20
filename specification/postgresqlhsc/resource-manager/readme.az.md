## AZ

These settings apply only when `--az` is specified on the command line.

``` yaml $(az)
az:
    extensions: postgresqlhsc
    namespace: azure.mgmt.postgresqlhsc
    package-name: azure-mgmt-postgresqlhsc
az-output-folder: $(azure-cli-extension-folder)/src/postgresqlhsc
python-sdk-output-folder: "$(az-output-folder)/azext_postgresqlhsc/vendored_sdks/postgresqlhsc"
# add additinal configuration here specific for Azure CLI
# refer to the faq.md for more details
```
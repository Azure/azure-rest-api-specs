## AZ

These settings apply only when `--az` is specified on the command line.

``` yaml $(az)
az:
  extensions: cosmosdb
  namespace: azure.mgmt.cosmosdb
  package-name: azure-mgmt-cosmosdb
az-output-folder: $(azure-cli-extension-folder)/src/cosmosdb
python-sdk-output-folder: "$(az-output-folder)/azext_cosmosdb/vendored_sdks/cosmosdb"
```

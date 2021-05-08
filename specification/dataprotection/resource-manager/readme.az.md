## AZ

These settings apply only when `--az` is specified on the command line.

``` yaml $(az)
az:
  extensions: dataprotection
  namespace: azure.mgmt.dataprotection
  package-name: azure-mgmt-dataprotection
az-output-folder: $(azure-cli-extension-folder)/src/dataprotection
python-sdk-output-folder: "$(az-output-folder)/azext_dataprotection/vendored_sdks/dataprotection"
```

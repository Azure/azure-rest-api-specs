## AZ

These settings apply only when `--az` is specified on the command line.

``` yaml $(az)
az:
  extensions: storagesync
  namespace: azure.mgmt.storagesync
  package-name: azure-mgmt-storagesync
az-output-folder: $(azure-cli-extension-folder)/src/storagesync
python-sdk-output-folder: "$(az-output-folder)/azext_storagesync/vendored_sdks/storagesync"
```

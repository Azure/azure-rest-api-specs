## AZ

These settings apply only when `--az` is specified on the command line.

``` yaml $(az)
az:
  extensions: storagecache
  namespace: azure.mgmt.storagecache
  package-name: azure-mgmt-storagecache
az-output-folder: $(azure-cli-extension-folder)/src/storagecache
python-sdk-output-folder: "$(az-output-folder)/azext_storagecache/vendored_sdks/storagecache"

```

## AZ

These settings apply only when `--az` is specified on the command line.

``` yaml $(az)
az:
  extensions: regionmove
  package-name: azure-mgmt-regionmove
  namespace: azure.mgmt.regionmove
az-output-folder: $(azure-cli-extension-folder)/src/regionmove
python-sdk-output-folder: "$(az-output-folder)/azext_regionmove/vendored_sdks/regionmove"
```

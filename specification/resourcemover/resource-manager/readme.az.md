## AZ

These settings apply only when `--az` is specified on the command line.

``` yaml $(az)
az:
  extensions: resourcemover
  package-name: azure-mgmt-resourcemover
  namespace: azure.mgmt.resourcemover
az-output-folder: $(azure-cli-extension-folder)/src/resourcemover
python-sdk-output-folder: "$(az-output-folder)/azext_resourcemover/vendored_sdks/resourcemover"
```

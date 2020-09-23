## AZ

These settings apply only when `--az` is specified on the command line.

``` yaml $(az)
az:
  extensions: databoxedge
  package-name: azure-mgmt-databoxedge
  namespace: azure.mgmt.databoxedge
az-output-folder: $(azure-cli-extension-folder)/src/databoxedge
python-sdk-output-folder: "$(az-output-folder)/azext_databoxedge/vendored_sdks/databoxedge"
```

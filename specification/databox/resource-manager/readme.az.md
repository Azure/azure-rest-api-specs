## CLI

These settings apply only when `--az` is specified on the command line.

``` yaml $(az)
az:
  extensions: databox
  package-name: azure-mgmt-databox
  namespace: azure.mgmt.databox
az-output-folder: $(azure-cli-extension-folder)/src/databox
python-sdk-output-folder: "$(az-output-folder)/azext_databox/vendored_sdks/databox"
```

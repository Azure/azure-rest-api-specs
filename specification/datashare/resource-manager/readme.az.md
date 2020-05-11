## AZ

These settings apply only when `--az` is specified on the command line.

``` yaml $(az)
az:
  extensions: datashare
  namespace: azure.mgmt.datashare
  package-name: azure-mgmt-datashare
az-output-folder: $(azure-cli-extension-folder)/src/datashare
python-sdk-output-folder: "$(az-output-folder)/azext_datashare/vendored_sdks/datashare"

```

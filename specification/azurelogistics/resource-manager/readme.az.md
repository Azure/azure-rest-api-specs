## AZ

These settings apply only when `--az` is specified on the command line.
Please also specify `--azure-cli-extension-folder=<path to output folder>`.

``` yaml $(az)
az:
  extensions: logistics
  namespace: azure.mgmt.logistics
  package-name: azure-mgmt-logistics
az-output-folder: $(azure-cli-extension-folder)/src/logistics
python-sdk-output-folder: "$(az-output-folder)/azext_logistics/vendored_sdks/logistics"
```

## AZ

These settings apply only when `--az` is specified on the command line.

``` yaml $(az) && $(target-mode) != 'core'
az:
  extensions: adp
  namespace: azure.mgmt.adp
  package-name: azure-mgmt-adp
az-output-folder: $(azure-cli-extension-folder)/src/adp
python-sdk-output-folder: "$(az-output-folder)/azext_adp/vendored_sdks/adp"
```

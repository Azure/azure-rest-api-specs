## AZ

These settings apply only when `--az` is specified on the command line.

``` yaml $(az) && $(target-mode) != 'core'
az:
  extensions: vi
  namespace: azure.mgmt.vi
  package-name: azure-mgmt-vi
az-output-folder: $(azure-cli-extension-folder)/src/vi
python-sdk-output-folder: "$(az-output-folder)/azext_vi/vendored_sdks/vi"
```

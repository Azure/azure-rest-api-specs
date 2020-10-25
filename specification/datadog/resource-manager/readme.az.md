## AZ

These settings apply only when `--az` is specified on the command line.

``` yaml $(az) && $(target-mode) != 'core'
az:
  extensions: datadog
  namespace: azure.mgmt.datadog
  package-name: azure-mgmt-datadog
az-output-folder: $(azure-cli-extension-folder)/src/datadog
python-sdk-output-folder: "$(az-output-folder)/azext_datadog/vendored_sdks/datadog"
```

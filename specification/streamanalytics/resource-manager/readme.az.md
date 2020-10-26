## AZ

These settings apply only when `--az` is specified on the command line.

``` yaml $(az)
az:
  extensions: streamanalytics
  package-name: azure-mgmt-streamanalytics
  namespace: azure.mgmt.streamanalytics
az-output-folder: $(azure-cli-extension-folder)/src/streamanalytics
python-sdk-output-folder: "$(az-output-folder)/azext_streamanalytics/vendored_sdks/streamanalytics"
```

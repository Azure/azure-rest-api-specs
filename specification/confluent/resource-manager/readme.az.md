## AZ

These settings apply only when `--az` is specified on the command line.

``` yaml $(az) && $(target-mode) != 'core'
az:
  extensions: confluent
  namespace: azure.mgmt.confluent
  package-name: azure-mgmt-confluent
az-output-folder: $(azure-cli-extension-folder)/src/confluent
python-sdk-output-folder: "$(az-output-folder)/azext_confluent/vendored_sdks/confluent"
```


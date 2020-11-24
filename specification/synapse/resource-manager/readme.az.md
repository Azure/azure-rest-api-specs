## AZ

These settings apply only when `--az` is specified on the command line.

``` yaml $(az) && $(target-mode) != 'core'
az:
  extensions: synapse
  namespace: azure.mgmt.synapse
  package-name: azure-mgmt-synapse
az-output-folder: $(azure-cli-extension-folder)/src/synapse
python-sdk-output-folder: "$(az-output-folder)/azext_synapse/vendored_sdks/synapse"
```

``` yaml $(az) && ($(target-mode) == 'core'
az:
  extensions: synapse
  namespace: azure.mgmt.synapse
  package-name: azure-mgmt-synapse
az-output-folder: $(azure-cli-folder)/src/azure-cli/azure/cli/command_modules/synapse
python-sdk-output-folder: "$(az-output-folder)/vendored_sdks/synapse"
```
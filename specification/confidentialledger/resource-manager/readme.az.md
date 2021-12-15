## AZ

These settings apply only when `--az` is specified on the command line.

``` yaml $(az) && $(target-mode) != 'core'
az:
    extensions: confidentialledger
    namespace: azure.mgmt.confidentialledger
    package-name: azure-mgmt-confidentialledger
az-output-folder: $(azure-cli-extension-folder)/src/confidentialledger
python-sdk-output-folder: "$(az-output-folder)/azext_confidentialledger/vendored_sdks/confidentialledger"
```

``` yaml $(az) && $(target-mode) == 'core'
az:
    extensions: confidentialledger
    namespace: azure.mgmt.confidentialledger
    package-name: azure-mgmt-confidentialledger
az-output-folder: $(azure-cli-folder)/src/azure-cli/azure/cli/command_modules/{serviceFolderName}
python-sdk-output-folder: "$(az-output-folder)/vendored_sdks/confidentialledger"
```
## AZ

These settings apply only when `--az` is specified on the command line.

For new Resource Provider. It is highly recommended to onboard Azure CLI extensions. There's no differences in terms of customer usage. 

```yaml $(az) && $(target-mode) != 'core'
az:
    extensions: quantum
    namespace: azure.mgmt.quantum
    package-name: azure-mgmt-quantum
az-output-folder: $(azure-cli-extension-folder)/src/quantum
python-sdk-output-folder: "$(az-output-folder)/azext_quantum/vendored_sdks/azure_mgmt_quantum"
```

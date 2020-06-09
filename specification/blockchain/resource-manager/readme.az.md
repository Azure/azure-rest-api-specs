## AZ

These settings apply only when `--az` is specified on the command line.

``` yaml $(az)
az:
  extensions: blockchain
  namespace: azure.mgmt.blockchain
  package-name: azure-mgmt-blockchain
az-output-folder: $(azure-cli-extension-folder)/src/blockchain
python-sdk-output-folder: "$(az-output-folder)/azext_blockchain/vendored_sdks/blockchain"
```

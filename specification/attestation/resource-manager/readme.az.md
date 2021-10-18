## Azure CLI

These settings apply only when `--az` is specified on the command line.

``` yaml $(az)
az:
  extensions: attestation
  package-name: azure-mgmt-attestation
  namespace: azure.mgmt.attestation
az-output-folder: $(azure-cli-extension-folder)/src/attestation
python-sdk-output-folder: "$(az-output-folder)/azext_attestation/vendored_sdks/attestation"
```

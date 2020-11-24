## AZ

These settings apply only when `--az` is specified on the command line.

``` yaml $(az)
az:
  extensions: aad
  namespace: azure.mgmt.aad
  package-name: azure-mgmt-aad
  disable-checks: true
  randomize-names: true
az-output-folder:  $(azure-cli-extension-folder)/src/aad
python-sdk-output-folder: "$(az-output-folder)/azext_aad/vendored_sdks/aad"
```
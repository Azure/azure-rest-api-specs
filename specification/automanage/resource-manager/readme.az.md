## AZ

These settings apply only when `--az` is specified on the command line.

``` yaml $(az)
az:
  extensions: automanage
  namespace: azure.mgmt.automanage
  package-name: azure-mgmt-automanage
az-output-folder: $(azure-cli-extension-folder)/src/automanage
python-sdk-output-folder: "$(az-output-folder)/azext_automanage/vendored_sdks/automanage"
```
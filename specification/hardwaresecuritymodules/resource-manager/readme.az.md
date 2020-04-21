## AZ

These settings apply only when `--az` is specified on the command line.

``` yaml $(az)
az:
  extensions: hardwaresecuritymodules
  namespace: azure.mgmt.hardwaresecuritymodules
  package-name: azure-mgmt-hardwaresecuritymodules
az-output-folder: $(azure-cli-extension-folder)/src/hardwaresecuritymodules
python-sdk-output-folder: "$(az-output-folder)/azext_hardwaresecuritymodules/vendored_sdks/hardwaresecuritymodules"
```

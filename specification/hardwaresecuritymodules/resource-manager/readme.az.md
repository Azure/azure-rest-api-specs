## AZ

These settings apply only when `--az` is specified on the command line.

``` yaml $(az)
az:
  extensions: hardware-security-modules
  namespace: azure.mgmt.hardwaresecuritymodules
  package-name: azure-mgmt-hardwaresecuritymodules
az-output-folder: $(azure-cli-extension-folder)/src/hardware-security-modules
python-sdk-output-folder: "$(az-output-folder)/azext_hardware_security_modules/vendored_sdks/hardwaresecuritymodules"
```

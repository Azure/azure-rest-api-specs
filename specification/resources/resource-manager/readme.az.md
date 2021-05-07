## AZ

These settings apply only when `--az` is specified on the command line.

``` yaml $(az) && $(target-mode) != 'core'
az:
    extensions: {svcName}
    namespace: azure.mgmt.{svcName}
    package-name: azure-mgmt-{svcName}
az-output-folder: $(azure-cli-extension-folder)/src/{svcName}
python-sdk-output-folder: "$(az-output-folder)/azext_{svcName}/vendored_sdks/{svcName}"
# add additinal configuration here specific for Azure CLI
# refer to the faq.md for more details
```
``` yaml $(az) && $(target-mode) == 'core'
az:
    extensions: {svcName}
    namespace: azure.mgmt.{svcName}
    package-name: azure-mgmt-{svcName}
az-output-folder: $(azure-cli-folder)/src/azure-cli/azure/cli/command_modules/{serviceFolderName}
python-sdk-output-folder: "$(az-output-folder)/vendored_sdks/{svcName}"
# add additinal configuration here specific for Azure CLI
# refer to the faq.md for more details
```

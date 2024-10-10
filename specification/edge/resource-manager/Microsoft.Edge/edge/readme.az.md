## AZ

These settings apply only when `--az` is specified on the command line.

For new Resource Provider. It is highly recommended to onboard Azure CLI extensions. There's no differences in terms of customer usage. 

``` yaml $(az) && $(target-mode) != 'core'
az:
    extensions: edgeupdates
    namespace: azure.mgmt.edgeupdates
    package-name: azure-mgmt-edgeupdates
az-output-folder: $(azure-cli-extension-folder)/src/edgeupdates
python-sdk-output-folder: "$(az-output-folder)/azext_edgeupdates/vendored_sdks/edgeupdates"
# add additional configuration here specific for Azure CLI
# refer to the faq.md for more details
```



This is for command modules that already in azure cli main repo. 
``` yaml $(az) && $(target-mode) == 'core'
az:
  extensions: edgeupdates
  namespace: azure.mgmt.edgeupdates
  package-name: azure-mgmt-edgeupdates
az-output-folder: $(azure-cli-folder)/src/azure-cli/azure/cli/command_modules/edgeupdates
python-sdk-output-folder: "$(az-output-folder)/vendored_sdks/edgeupdates"
``` 
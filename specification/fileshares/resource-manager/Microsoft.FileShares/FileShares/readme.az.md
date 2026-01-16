## AZ

These settings apply only when `--az` is specified on the command line.

For new Resource Provider. It is highly recommended that new resource providers integrate with Azure CLI extensions. From the customer's perspective, there is no difference in usage experience. 

``` yaml $(az) && $(target-mode) != 'core'
az:
    extensions: fileshares
    namespace: azure.mgmt.fileshares
    package-name: azure-mgmt-fileshares
az-output-folder: $(azure-cli-extension-folder)/src/fileshares
python-sdk-output-folder: "$(az-output-folder)/azext_fileshares/vendored_sdks/fileshares"
# add additional configuration here specific for Azure CLI
# refer to the faq.md for more details
```



This is for command modules that already in azure cli main repo. 
``` yaml $(az) && $(target-mode) == 'core'
az:
  extensions: fileshares
  namespace: azure.mgmt.fileshares
  package-name: azure-mgmt-fileshares
az-output-folder: $(azure-cli-folder)/src/azure-cli/azure/cli/command_modules/fileshares
python-sdk-output-folder: "$(az-output-folder)/vendored_sdks/fileshares"
``` 

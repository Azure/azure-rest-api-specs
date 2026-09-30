## AZ

These settings apply only when `--az` is specified on the command line.

For new Resource Provider. It is highly recommended to onboard Azure CLI extensions. There's no differences in terms of customer usage. 

``` yaml $(az) && $(target-mode) != 'core'
az:
    extensions: mission
    namespace: azure.mgmt.mission
    package-name: azure-mgmt-mission
az-output-folder: $(azure-cli-extension-folder)/src/mission
python-sdk-output-folder: "$(az-output-folder)/azext_mission/vendored_sdks/mission"
# add additional configuration here specific for Azure CLI
# refer to the faq.md for more details
```



This is for command modules that already in azure cli main repo. 
``` yaml $(az) && $(target-mode) == 'core'
az:
  extensions: mission
  namespace: azure.mgmt.mission
  package-name: azure-mgmt-mission
az-output-folder: $(azure-cli-folder)/src/azure-cli/azure/cli/command_modules/mission
python-sdk-output-folder: "$(az-output-folder)/vendored_sdks/mission"
``` 
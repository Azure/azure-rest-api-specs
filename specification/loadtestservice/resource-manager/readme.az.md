## AZ

These settings apply only when `--az` is specified on the command line.

For new Resource Provider. It is highly recommended to onboard Azure CLI extensions. There's no differences in terms of customer usage. 

``` yaml $(az) && $(target-mode) != 'core'
az:
    extensions: loadtestservice
    namespace: azure.mgmt.loadtestservice
    package-name: azure-mgmt-loadtestservice
az-output-folder: $(azure-cli-extension-folder)/src/loadtestservice
python-sdk-output-folder: "$(az-output-folder)/azext_loadtestservice/vendored_sdks/loadtestservice"
# add additional configuration here specific for Azure CLI
# refer to the faq.md for more details
```



This is for command modules that already in azure cli main repo. 
``` yaml $(az) && $(target-mode) == 'core'
az:
  extensions: loadtestservice
  namespace: azure.mgmt.loadtestservice
  package-name: azure-mgmt-loadtestservice
az-output-folder: $(azure-cli-folder)/src/azure-cli/azure/cli/command_modules/loadtestservice
python-sdk-output-folder: "$(az-output-folder)/vendored_sdks/loadtestservice"
``` 
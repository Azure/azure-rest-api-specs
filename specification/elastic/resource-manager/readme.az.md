## AZ

These settings apply only when `--az` is specified on the command line.

For new Resource Provider. It is highly recommended to onboard Azure CLI extensions. There's no differences in terms of customer usage. 

``` yaml $(az) && $(target-mode) != 'core'
az:
    extensions: elastic
    namespace: azure.mgmt.elastic
    package-name: azure-mgmt-elastic
az-output-folder: $(azure-cli-extension-folder)/src/elastic
python-sdk-output-folder: "$(az-output-folder)/azext_elastic/vendored_sdks/elastic"
# add additional configuration here specific for Azure CLI
# refer to the faq.md for more details
cli:
  cli-directive:
    ## rename a parameter
    - where:
        gruop: elastic monitor
        op: create
        param: name
      name: sku
directive:
  - where:
      command: elastic monitored-resource list
    set:
      command: elastic monitor list-resource
  - where:
      command: elastic deployment-info list
    set:
      command: elastic monitor list-deployment-info
  - where:
      group: elastic tag-rule
    set:
      group: elastic monitor tag-rule
  - where:
      command: elastic vm-host list
    set:
      command: elastic monitor list-vm-host
  - where:
      command: elastic vm-ingestion detail
    set:
      command: elastic monitor list-vm-ingestion-detail
  - where:
      command: elastic vm-collection update
    set:
      command: elastic monitor update-vm-collection
```



This is for command modules that already in azure cli main repo. 
``` yaml $(az) && $(target-mode) == 'core'
az:
  extensions: elastic
  namespace: azure.mgmt.elastic
  package-name: azure-mgmt-elastic
az-output-folder: $(azure-cli-folder)/src/azure-cli/azure/cli/command_modules/elastic
python-sdk-output-folder: "$(az-output-folder)/vendored_sdks/elastic"
``` 
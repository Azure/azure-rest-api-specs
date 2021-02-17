## AZ

These settings apply only when `--az` is specified on the command line.

``` yaml $(az) && $(target-mode) != 'core'
az:
    extensions: redisenterprise
    namespace: azure.mgmt.redisenterprise
    package-name: azure-mgmt-redisenterprise
az-output-folder: $(azure-cli-extension-folder)/src/redisenterprise
python-sdk-output-folder: "$(az-output-folder)/azext_redisenterprise/vendored_sdks/redisenterprise"
```
``` yaml $(az) && $(target-mode) == 'core'
az:
    extensions: redisenterprise
    namespace: azure.mgmt.redisenterprise
    package-name: azure-mgmt-redisenterprise
az-output-folder: $(azure-cli-folder)/src/azure-cli/azure/cli/command_modules/redisenterprise
python-sdk-output-folder: "$(az-output-folder)/vendored_sdks/redisenterprise"
```

Additional configuration specific for Azure CLI

``` yaml
extension-mode: stable

cli:
    cli-directive:
      - where:
          group: '*'
          op: '*'
          param: 'clusterName'
        alias:
          - cluster_name
          - name
          - n
      - where:
          group: '*'
          op: '*'
          param: 'zones'
        alias:
          - zones
          - z

directive:
  - where:
      group: redisenterprise redis-enterprise
    set:
      group: redisenterprise
```

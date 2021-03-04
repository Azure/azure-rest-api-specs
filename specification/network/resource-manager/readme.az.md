## Azure CLI

These settings apply only when `--az` is specified on the command line.

``` yaml $(az) && $(target-mode) == "core"
az:
  extensions: network
  namespace: azure.mgmt.network
  package-name: azure-mgmt-network
  disable-checks: true
  randomize-names: true
  test-unique-resource: true
az-output-folder: $(azure-cli-folder)/src/azure-cli/azure/cli/command_modules/network
python-sdk-output-folder: "$(azure-cli-folder)/src/azure-cli/azure/cli/command_modules/network/vendored_sdks/network"
compatible-level: track2

cli:
  cli-directive:
    - where:
        group: "*"
        op: "*"
        param: networkSecurityGroupName
      name: nsgName
    - where:
        group: "*"
        op: "*"
        param: virtualNetworkName
      name: vnetName
    - where:
        group: PrivateLinkServices
        op: "*"
        param: serviceName
      name: name
```

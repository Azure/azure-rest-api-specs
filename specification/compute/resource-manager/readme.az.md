## AZ

These settings apply only when `--az` is specified on the command line.

``` yaml $(az)
az:
  extensions: vm
  namespace: azure.mgmt.vm
  package-name: azure-mgmt-vm
az-output-folder: $(azure-cli-folder)/src/azure-cli/azure/cli/command_modules/vm
cli:
    cli-directive:
        - where:
            group: "*"
            op: "*"
          hidden: true
        - where:
            group: "SshPublicKeys"
            op: "*"
          hidden: false
```
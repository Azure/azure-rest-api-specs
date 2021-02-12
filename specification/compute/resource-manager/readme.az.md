## AZ

These settings apply only when `--az` is specified on the command line.

``` yaml $(az) && $(target-mode) == "core"
az:
  extensions: vm
  namespace: azure.mgmt.compute
  package-name: azure-mgmt-compute
az-output-folder: $(azure-cli-folder)/src/azure-cli/azure/cli/command_modules/vm
python-sdk-output-folder: "$(az-output-folder)/vendored_sdks/vm"
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
directive: 
  - where: 
      command: vm ssh-public-key
    set:
      command: sshkey
```
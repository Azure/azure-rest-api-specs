# AZ HybridCompute

These settings apply only when `--az` is specified on the command line.

``` yaml $(az)
az:
    extensions: connectedmachine
    namespace: azure.mgmt.connectedmachine
    package-name: azure-mgmt-connectedmachine
az-output-folder: $(azure-cli-extension-folder)/src/connectedmachine
python-sdk-output-folder: "$(az-output-folder)/azext_connectedmachine/vendored_sdks/connectedmachine"
directive:
  - where:
      subject: MachineExtension
      parameter-name: name
    set:
      parameter-name: machine-name
  - where:
      subject: MachineExtension
      parameter-name: extension-name
    set:
      parameter-name: name
  - where:
      group: connectedmachine machine$
    set:
      group: connectedmachine
  - where:
      group: connectedmachine machine-extension$
    set:
      group: connectedmachine extension
```

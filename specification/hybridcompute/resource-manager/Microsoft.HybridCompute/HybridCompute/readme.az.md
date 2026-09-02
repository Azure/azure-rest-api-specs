# AZ HybridCompute

These settings apply only when `--az` is specified on the command line.

``` yaml $(az)
az:
    extensions: connectedmachine
    namespace: azure.mgmt.connectedmachine
    package-name: azure-mgmt-connectedmachine
az-output-folder: $(azure-cli-extension-folder)/src/connectedmachine
python-sdk-output-folder: "$(az-output-folder)/azext_connectedmachine/vendored_sdks/connectedmachine"
extension-mode: stable
directive:
  # renaming params
  - where:
      subject: MachineExtension
      parameter-name: extension-name
    set:
      parameter-name: name
  - where:
      subject: MachineExtension
      parameter-name: auto-upgrade-minor-version
    set:
      parameter-name: auto-upgrade-minor
  - where:
      subject: MachineExtension
      parameter-name: machine-extension-instance-view-type-handler-version-type-handler-version
    set:
      parameter-name: inst-handler-version
  - where:
      subject: MachineExtension
      parameter-name: machine-extension-instance-view-type
    set:
      parameter-name: instance-view-type
  - where:
      subject: MachineExtension
      parameter-name: enable-automatic-upgrade
    set:
      parameter-name: enable-auto-upgrade
  - where:
      subject: PrivateEndpointConnections
      parameter-name: private-link-service-connection-state
    set:
      parameter-name: connection-state
  # renaming groups
  - where:
      group: connectedmachine machine
    set:
      group: connectedmachine
  - where:
      group: connectedmachine machine-extension
    set:
      group: connectedmachine extension
```
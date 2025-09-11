## AZ

These settings apply only when `--az` is specified on the command line.

``` yaml $(az)
az:
  extensions: connectedvehicle
  package-name: azure-mgmt-connectedvehicle
  namespace: azure.mgmt.connectedvehicle
az-output-folder: $(azure-cli-extension-folder)/src/connectedvehicle
python-sdk-output-folder: "$(az-output-folder)/azext_connectedvehicle/vendored_sdks/connectedvehicle"
directive: 
  - where: 
      command: connectedvehicle platform-account get-property
    set:
      command: connectedvehicle platform-account show
```
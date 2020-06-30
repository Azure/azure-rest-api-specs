## AZ

These settings apply only when `--az` is specified on the command line.

``` yaml $(az)
az:
  extensions: mobility
  package-name: azure-mgmt-mobility
  namespace: azure.mgmt.mobility
az-output-folder: $(azure-cli-extension-folder)/src/mobility
python-sdk-output-folder: "$(az-output-folder)/azext_mobility/vendored_sdks/mobility"
directive: 
  - where: 
      command: mobility mcvp-account get-property
    set:
      command: mobility mcvp-account show
```
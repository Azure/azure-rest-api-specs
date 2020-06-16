## AZ

These settings apply only when `--az` is specified on the command line.

``` yaml $(az)
az:
  extensions: desktopvirtualization
  package-name: azure-mgmt-desktopvirtualization
  namespace: azure.mgmt.desktopvirtualization
az-output-folder: $(azure-cli-extension-folder)/src/desktopvirtualization
python-sdk-output-folder: "$(az-output-folder)/azext_desktopvirtualization/vendored_sdks/desktopvirtualization"

directive:
  - where:
      group: desktopvirtualization host-pool
    set:
      group: desktopvirtualization hostpool
  - where:
      group: desktopvirtualization application-group
    set:
      group: desktopvirtualization applicationgroup
```

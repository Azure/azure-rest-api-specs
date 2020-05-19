## AZ

These settings apply only when `--az` is specified on the command line.

``` yaml $(az)
az:
  extensions: windows-virtual-desktop
  package-name: azure-mgmt-desktopvirtualization
  namespace: azure.mgmt.desktopvirtualization
az-output-folder: $(azure-cli-extension-folder)/src/windowsvirtualdesktop
python-sdk-output-folder: "$(az-output-folder)/azext_windows_virtual_desktop/vendored_sdks/desktopvirtualization"

directive:
  - where:
      group: windows-virtual-desktop host-pool
    set:
      group: windows-virtual-desktop hostpool
  - where:
      group: windows-virtual-desktop application-group
    set:
      group: windows-virtual-desktop applicationgroup
```

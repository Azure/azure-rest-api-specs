## AZ

These settings apply only when `--az` is specified on the command line.

``` yaml $(az)
az:
  extensions: windows-virtual-desktop
  package-name: azure-mgmt-windowsvirtualdesktop
  namespace: azure.mgmt.windowsvirtualdesktop
az-output-folder: $(azure-cli-extension-folder)/src/windowsvirtualdesktop
python-sdk-output-folder: "$(az-output-folder)/azext_windows_virtual_desktop/vendored_sdks/desktopvirtualization"
```

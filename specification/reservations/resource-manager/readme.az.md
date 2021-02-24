# AZ reservations

These settings apply only when `--az` is specified on the command line.

``` yaml $(az)
az:
    extensions: quota
    namespace: azure.mgmt.reservations
    package-name: azure-mgmt-reservations
az-output-folder: $(azure-cli-extension-folder)/src/reservations
```

# AZ reservations

These settings apply only when `--az` is specified on the command line.

``` yaml $(az)
az:
    extensions: reservations
    namespace: azure.mgmt.reservations
    package-name: azure-mgmt-reservations
az-output-folder: $(azure-cli-extension-folder)/src/reservations
python-sdk-output-folder: "$(az-output-folder)/azext_reservations/vendored_sdks/reservations"
```

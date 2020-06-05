## AZ

These settings apply only when `--az` is specified on the command line.

``` yaml $(az)
az:
  extensions: guestconfig
  namespace: azure.mgmt.guestconfig
  package-name: azure-mgmt-guestconfig
az-output-folder: $(azure-cli-extension-folder)/src/guestconfig
python-sdk-output-folder: "$(az-output-folder)/azext_guestconfig/vendored_sdks/guestconfig"

cli:
    cli-directive:
        - where:
            type: 'GuestConfigurationAssignment'
            prop: 'properties'
          flatten: true


```

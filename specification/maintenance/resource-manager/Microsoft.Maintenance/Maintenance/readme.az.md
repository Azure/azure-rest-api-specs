## AZ

These settings apply only when `--az` is specified on the command line.

``` yaml $(az)
az:
  extensions: maintenance
  namespace: azure.mgmt.maintenance
  package-name: azure-mgmt-maintenance
az-output-folder: $(azure-cli-extension-folder)/src/maintenance
python-sdk-output-folder: "$(az-output-folder)/azext_maintenance/vendored_sdks/maintenance"

directive:
  - where:
      group: maintenance apply-update
    set:
      group: maintenance applyupdate
  - where:
      group: maintenance maintenance-configuration
    set:
      group: maintenance configuration
  - where:
      group: maintenance configuration-assignment
    set:
      group: maintenance assignment
  - where:
      group: maintenance public-maintenance-configuration
    set:
      group: maintenance public-configuration

```

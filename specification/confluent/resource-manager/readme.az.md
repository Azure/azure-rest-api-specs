## AZ

These settings apply only when `--az` is specified on the command line.

``` yaml $(az) && $(target-mode) != 'core'
az:
  extensions: confluent
  namespace: azure.mgmt.confluent
  package-name: azure-mgmt-confluent
az-output-folder: $(azure-cli-extension-folder)/src/confluent
python-sdk-output-folder: "$(az-output-folder)/azext_confluent/vendored_sdks/confluent"

directive:
  - where:
      group: marketplace-agreement
    set:
      group: terms
cli:
  cli-directive:
    - where:
        group: MarketplaceAgreements
        op: Create
      hidden: true
    - where:
        group: OrganizationOperations
      hidden: true
    - where:
        group: Organization
        op: Create
        param: provisioningState
      hidden: true
```

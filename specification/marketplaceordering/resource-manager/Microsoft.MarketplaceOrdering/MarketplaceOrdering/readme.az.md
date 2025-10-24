## AZ

These settings apply only when `--az` is specified on the command line.

For new Resource Provider. It is highly recommended to onboard Azure CLI extensions. There's no differences in terms of customer usage. 

This is for command modules that already in azure cli main repo. 
``` yaml $(az) && $(target-mode) == 'core'
az:
    extensions: marketplaceordering
    namespace: azure.mgmt.marketplaceordering
    package-name: azure-mgmt-marketplaceordering
az-output-folder: $(azure-cli-folder)/src/azure-cli/azure/cli/command_modules/marketplaceordering
python-sdk-output-folder: "$(az-output-folder)/vendored_sdks/marketplaceordering"

``` 

``` yaml
directive:
  - where:
      group: marketplaceordering marketplace-agreement
    set:
      group: term
  - where:
      command: term create
    set:
      command: term accept
  - where:
      command: term accept
    set:
      command-description: Accept marketplace terms.
  - where: 
      parameter-name: publisher-id 
    set:
      parameter-name: publisher
  - where: 
      parameter-name: offer-id 
    set:
      parameter-name: product
  - where: 
      parameter-name: plan-id 
    set:
      parameter-name: plan

cli:
  cli-directive:
    - where:
        group: MarketplaceAgreements
        op: GetAgreement
      hidden: true
    - where:
        group: MarketplaceAgreements
        op: Sign
      hidden: true
    - where:
        group: MarketplaceAgreements
        op: Cancel
      hidden: true
    - where:
        group: MarketplaceAgreements
        op: List
      hidden: true
    - where:
        group: MarketplaceAgreements
        set:
          extensionMode: preview
    - where:
        group: MarketplaceAgreements
        parameter: offerType
      default-value: virtualmachine
    - where:
        group: MarketplaceAgreements
        op: Create
        param: licenseTextLink
      hidden: true
    - where:
        group: MarketplaceAgreements
        op: Create
        param: privacyPolicyLink
      hidden: true
    - where:
        group: MarketplaceAgreements
        op: Create
        param: marketplaceTermsLink
      hidden: true
    - where:
        group: MarketplaceAgreements
        op: Create
        param: retrieveDatetime
      hidden: true
    - where:
        group: MarketplaceAgreements
        op: Create
        param: signature
      hidden: true
    - where:
        group: MarketplaceAgreements
        op: Create
        param: accepted
      hidden: true
```

## Trenton

These settings apply only when `--trenton` is specified on the command line.

``` yaml $(trenton)
trenton:
  cli_name: customproviders
  azure_arm: true
  license_header: MICROSOFT_MIT_NO_VERSION
  payload_flattening_threshold: 2
  namespace: azure.mgmt.customproviders
  package_name: azure-mgmt-customproviders
  clear_output_folder: false
overrides:
  - where:
      property: resourceProviderName
    set:
    - IdPortion: "resourceproviders"
```

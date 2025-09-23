## Terraform

These settings apply only when `--terraform` is specified on the command line.

``` yaml $(terraform)
terraform:
  cli-name: customproviders
  azure_arm: true
  license_header: MICROSOFT_MIT_NO_VERSION
  payload_flattening_threshold: 2
  namespace: azure.mgmt.customproviders
  package_name: azure-mgmt-customproviders
  clear-output-folder: true
overrides:
  - where:
      property: resourceProviderName
    set:
    - IdPortion: "resourceproviders"
```

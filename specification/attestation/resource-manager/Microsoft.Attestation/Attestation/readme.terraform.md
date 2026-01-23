
## Terraform

These settings apply only when `--terraform` is specified on the command line.

``` yaml $(terraform)
terraform:
    cli-name: attestation
    package-name: attestation
clear-output-folder: true
output-folder: $(terraform-output-folder)/attestation
overrides:
  - where:
      property: "x5C"
    set:
      - GoFieldName: X5c
  - where:
      property: "/creationParams/properties"
    set:
      - GoFieldName: Properties
```

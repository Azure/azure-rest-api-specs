## Terraform

These settings apply only when `--terraform` is specified on the command line.

``` yaml $(terraform)
terraform:
    cli-name: azurefleet
    package-name: azurefleet
clear-output-folder: true
output-folder: $(terraform-output-folder)/azurefleet
```

## overrides

These settings apply only when `--terraform` is specified on the command line.
``` yaml $(terraform)
overrides:
  - where:
      resource: "*"
    set:
      - NeedSeparated: false
  - where:
      resource: "Accounts"
    set:
      - CombineCreateUpdate: false
```
## Terraform

These settings apply only when `--terraform` is specified on the command line.

``` yaml $(terraform)
terraform:
    cli-name: dataShare
    package-name: datashare
clear-output-folder: true
output-folder: $(terraform-output-folder)/datashare
```

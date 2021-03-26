
## Terraform

These settings apply only when `--terraform` is specified on the command line.

``` yaml $(terraform)
terraform:
    cli-name: resourcemover
    package-name: resourcemover
clear-output-folder: true
output-folder: $(terraform-output-folder)/resourcemover
```

``` yaml $(terraform)
overrides:
  - where:
      property: dependsOn
    set:
      - SchemaName: "dependency"
```

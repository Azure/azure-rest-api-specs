
## Terraform

These settings apply only when `--terraform` is specified on the command line.

<!-- ``` yaml $(terraform)
terraform:
    cli-name: features
    package-name: features
clear-output-folder: true
output-folder: $(terraform-output-folder)/features
``` -->
``` yaml $(terraform)
batch:
  - package-features: true
```

```yaml $(terraform) && $(package-features)
terraform:
  cli-name: features
  package-name: features
output-folder: $(terraform-output-folder)/features
clear-output-folder: true
```

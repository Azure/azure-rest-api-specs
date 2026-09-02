
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
  - package-policy: true
```

```yaml $(terraform) && $(package-policy)
terraform:
  cli-name: policy
  package-name: policy
output-folder: $(terraform-output-folder)/policy
clear-output-folder: true
```
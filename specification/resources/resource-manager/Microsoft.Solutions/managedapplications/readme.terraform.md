
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
  - package-managedapplications: true
```

```yaml $(terraform) && $(package-managedapplications)
terraform:
  cli-name: managedApplications
  package-name: managedapplications
output-folder: $(terraform-output-folder)/managedapplications
clear-output-folder: true

overrides:
  - where:
      resource: "Applications"
      property: "/parameters"
    set:
      - GoVariableName: "appParameters"
      - Gen: "newgen"
```
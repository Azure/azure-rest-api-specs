
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


```yaml $(tag) == 'package-2019-10-01-preview' && $(terraform)
gosdk-folder: services/preview/resourcemover/mgmt/2019-10-01-preview/resourcemover
```

```yaml $(tag) == 'package-2021-01-01' && $(terraform)
gosdk-folder: services/resourcemover/mgmt/2021-01-01/resourcemover
```

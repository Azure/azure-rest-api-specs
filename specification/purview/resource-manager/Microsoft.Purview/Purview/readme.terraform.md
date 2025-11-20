## overrides

These settings apply only when `--terraform` is specified on the command line.
``` yaml $(terraform)
overrides:
```
## Terraform

These settings apply only when `--terraform` is specified on the command line.

``` yaml $(terraform)
terraform:
    cli-name: purview
    package-name: purview
clear-output-folder: true
output-folder: $(terraform-output-folder)/purview
```

``` yaml $(tag) == 'package-2020-12-01-preview' && $(terraform)
gosdk-folder: services/preview/purview/mgmt/2020-12-01-preview/purview
```

``` yaml $(tag) == 'package-2021-07-01' && $(terraform)
gosdk-folder: services/purview/mgmt/2021-07-01/purview
```
```
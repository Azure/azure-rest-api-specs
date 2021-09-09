
## terraform

These settings apply only when `--terraform` is specified on the command line.

``` yaml $(terraform)
terraform:
    cli-name: adp
    package-name: adp
clear-output-folder: true
output-folder: $(terraform-output-folder)/adp
```

``` yaml $(tag) == 'package-2020-07-01-preview' && $(terraform)
gosdk-folder: services/preview/adp/mgmt/2020-07-01-preview/adp
```

``` yaml $(tag) == 'package-2021-02-01-preview' && $(terraform)
gosdk-folder: services/preview/adp/mgmt/2021-02-01-preview/adp
```
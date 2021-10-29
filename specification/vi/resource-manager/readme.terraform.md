
## terraform

These settings apply only when `--terraform` is specified on the command line.

``` yaml $(terraform)
terraform:
    cli-name: vi
    package-name: vi
clear-output-folder: true
output-folder: $(terraform-output-folder)/vi
```

``` yaml $(tag) == 'package-2021-10-18-preview' && $(terraform)
gosdk-folder: services/preview/vi/mgmt/2021-10-18-preview/vi
```

``` yaml $(tag) == 'package-2021-10-27-preview' && $(terraform)
gosdk-folder: services/preview/vi/mgmt/2021-10-27-preview/vi
```
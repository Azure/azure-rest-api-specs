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

``` yaml $(tag) == 'package-2018-11-01-preview' && $(terraform)
gosdk-folder: services/preview/datashare/mgmt/2018-11-01-preview/datashare
```

``` yaml $(tag) == 'package-2019-11-01' && $(terraform)
gosdk-folder: services/datashare/mgmt/2019-11-01/datashare
```

``` yaml $(tag) == 'package-2020-09-01' && $(terraform)
gosdk-folder: services/datashare/mgmt/2020-09-01/datashare
```

``` yaml $(tag) == 'package-2020-10-01-preview' && $(terraform)
gosdk-folder: services/preview/datashare/mgmt/2020-10-01-preview/datashare
```

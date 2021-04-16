
## terraform

These settings apply only when `--terraform` is specified on the command line.

``` yaml $(terraform)
terraform:
    cli-name: enterpriseknowledgegraphservice
    package-name: enterpriseknowledgegraphservice
clear-output-folder: true
output-folder: $(terraform-output-folder)/enterpriseknowledgegraphservice
```

``` yaml $(tag) == 'package-2018-12-03' && $(terraform)
gosdk-folder: services/preview/enterpriseknowledgegraphservice/2018-12-03/enterpriseknowledgegraphservice
```

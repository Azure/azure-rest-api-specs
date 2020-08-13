## AzureResourceSchema

These settings apply only when `--azureresourceschema` is specified on the command line.

### AzureResourceSchema multi-api

``` yaml $(azureresourceschema) && $(multiapi)
batch:
  - tag: package-preview-2020-07
  - tag: package-2017-04-01
```

### Tag: package-preview-2020-07 and azureresourceschema

These settings apply only when `--tag=package-preview-2020-07 --azureresourceschema` is specified on the command line.
Please also specify `--azureresourceschema-folder=<path to the root directory of your azure-resource-manager-schemas clone>`.

``` yaml $(tag) == 'package-preview-2020-07' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas
```

### Tag: package-2017-04-01 and azureresourceschema

These settings apply only when `--tag=package-2017-04-01 --azureresourceschema` is specified on the command line.
Please also specify `--azureresourceschema-folder=<path to the root directory of your azure-resource-manager-schemas clone>`.

``` yaml $(tag) == 'package-2017-04-01' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas
```


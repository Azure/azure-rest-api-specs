## AzureResourceSchema

These settings apply only when `--azureresourceschema` is specified on the command line.

### AzureResourceSchema multi-api

``` yaml $(azureresourceschema) && $(multiapi)
batch:
  - tag: package-2018-11-30
  - tag: package-2015-08-31-preview
```

### Tag: package-2018-11-30 and azureresourceschema

These settings apply only when `--tag=package-2018-11-30 --azureresourceschema` is specified on the command line.
Please also specify `--azureresourceschema-folder=<path to the root directory of your azure-resource-manager-schemas clone>`.

``` yaml $(tag) == 'package-2018-11-30' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas
```

### Tag: package-2015-08-31-preview and azureresourceschema

These settings apply only when `--tag=package-2015-08-31-preview --azureresourceschema` is specified on the command line.
Please also specify `--azureresourceschema-folder=<path to the root directory of your azure-resource-manager-schemas clone>`.

``` yaml $(tag) == 'package-2015-08-31-preview' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas
```


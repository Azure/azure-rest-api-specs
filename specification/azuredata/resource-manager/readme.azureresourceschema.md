## AzureResourceSchema

These settings apply only when `--azureresourceschema` is specified on the command line.

### AzureResourceSchema multi-api

``` yaml $(azureresourceschema) && $(multiapi)
batch:
  - tag: package-preview-2019-07
  - tag: package-2017-03-01-preview
```

### Tag: package-preview-2019-07 and azureresourceschema

These settings apply only when `--tag=package-preview-2019-07 --azureresourceschema` is specified on the command line.
Please also specify `--azureresourceschema-folder=<path to the root directory of your azure-resource-manager-schemas clone>`.

``` yaml $(tag) == 'package-preview-2019-07' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas
```

### Tag: package-2017-03-01-preview and azureresourceschema

These settings apply only when `--tag=package-2017-03-01-preview --azureresourceschema` is specified on the command line.
Please also specify `--azureresourceschema-folder=<path to the root directory of your azure-resource-manager-schemas clone>`.

``` yaml $(tag) == 'package-2017-03-01-preview' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas
```


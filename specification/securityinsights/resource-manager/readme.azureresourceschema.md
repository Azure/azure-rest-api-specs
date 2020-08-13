## AzureResourceSchema

These settings apply only when `--azureresourceschema` is specified on the command line.

### AzureResourceSchema multi-api

``` yaml $(azureresourceschema) && $(multiapi)
batch:
  - tag: package-composite-v1
  - tag: package-2019-01-preview-only
```

### Tag: package-composite-v1 and azureresourceschema

These settings apply only when `--tag=package-composite-v1 --azureresourceschema` is specified on the command line.
Please also specify `--azureresourceschema-folder=<path to the root directory of your azure-resource-manager-schemas clone>`.

``` yaml $(tag) == 'package-composite-v1' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas
```

### Tag: package-2019-01-preview-only and azureresourceschema

These settings apply only when `--tag=package-2019-01-preview-only --azureresourceschema` is specified on the command line.
Please also specify `--azureresourceschema-folder=<path to the root directory of your azure-resource-manager-schemas clone>`.

``` yaml $(tag) == 'package-2019-01-preview-only' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas
```


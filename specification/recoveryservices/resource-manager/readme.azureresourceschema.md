## AzureResourceSchema

These settings apply only when `--azureresourceschema` is specified on the command line.

### AzureResourceSchema multi-api

``` yaml $(azureresourceschema) && $(multiapi)
batch:
  - tag: package-2016-06
```

### Tag: package-2016-06 and azureresourceschema

These settings apply only when `--tag=package-2016-06 --azureresourceschema` is specified on the command line.
Please also specify `--azureresourceschema-folder=<path to the root directory of your azure-resource-manager-schemas clone>`.

``` yaml $(tag) == 'package-2016-06' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas
```


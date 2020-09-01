## AzureResourceSchema

These settings apply only when `--azureresourceschema` is specified on the command line.

### AzureResourceSchema multi-api

``` yaml $(azureresourceschema) && $(multiapi)
batch:
  - tag: package-2017-10-preview
```

### Tag: package-2017-10-preview and azureresourceschema

These settings apply only when `--tag=package-2017-10-preview --azureresourceschema` is specified on the command line.
Please also specify `--azureresourceschema-folder=<path to the root directory of your azure-resource-manager-schemas clone>`.

``` yaml $(tag) == 'package-2017-10-preview' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas
```


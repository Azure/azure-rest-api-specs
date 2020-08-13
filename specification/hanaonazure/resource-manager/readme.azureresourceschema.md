## AzureResourceSchema

These settings apply only when `--azureresourceschema` is specified on the command line.

### AzureResourceSchema multi-api

``` yaml $(azureresourceschema) && $(multiapi)
batch:
  - tag: package-2017-11
  - tag: package-2020-02-07-preview
```

### Tag: package-2017-11 and azureresourceschema

These settings apply only when `--tag=package-2017-11 --azureresourceschema` is specified on the command line.
Please also specify `--azureresourceschema-folder=<path to the root directory of your azure-resource-manager-schemas clone>`.

``` yaml $(tag) == 'package-2017-11' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas
```

### Tag: package-2020-02-07-preview and azureresourceschema

These settings apply only when `--tag=package-2020-02-07-preview --azureresourceschema` is specified on the command line.
Please also specify `--azureresourceschema-folder=<path to the root directory of your azure-resource-manager-schemas clone>`.

``` yaml $(tag) == 'package-2020-02-07-preview' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas
```


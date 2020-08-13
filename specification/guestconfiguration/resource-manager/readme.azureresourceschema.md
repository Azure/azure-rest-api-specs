## AzureResourceSchema

These settings apply only when `--azureresourceschema` is specified on the command line.

### AzureResourceSchema multi-api

``` yaml $(azureresourceschema) && $(multiapi)
batch:
  - tag: package-2020-06-25
  - tag: package-2018-11-20
  - tag: package-2018-06-30-preview
  - tag: package-2018-01-20-preview
```

### Tag: package-2020-06-25 and azureresourceschema

These settings apply only when `--tag=package-2020-06-25 --azureresourceschema` is specified on the command line.
Please also specify `--azureresourceschema-folder=<path to the root directory of your azure-resource-manager-schemas clone>`.

``` yaml $(tag) == 'package-2020-06-25' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas
```

### Tag: package-2018-11-20 and azureresourceschema

These settings apply only when `--tag=package-2018-11-20 --azureresourceschema` is specified on the command line.
Please also specify `--azureresourceschema-folder=<path to the root directory of your azure-resource-manager-schemas clone>`.

``` yaml $(tag) == 'package-2018-11-20' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas
```

### Tag: package-2018-06-30-preview and azureresourceschema

These settings apply only when `--tag=package-2018-06-30-preview --azureresourceschema` is specified on the command line.
Please also specify `--azureresourceschema-folder=<path to the root directory of your azure-resource-manager-schemas clone>`.

``` yaml $(tag) == 'package-2018-06-30-preview' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas
```

### Tag: package-2018-01-20-preview and azureresourceschema

These settings apply only when `--tag=package-2018-01-20-preview --azureresourceschema` is specified on the command line.
Please also specify `--azureresourceschema-folder=<path to the root directory of your azure-resource-manager-schemas clone>`.

``` yaml $(tag) == 'package-2018-01-20-preview' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas
```


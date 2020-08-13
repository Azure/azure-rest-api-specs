## AzureResourceSchema

These settings apply only when `--azureresourceschema` is specified on the command line.

### AzureResourceSchema multi-api

``` yaml $(azureresourceschema) && $(multiapi)
batch:
  - tag: package-2015-10
  - tag: package-2017-05-preview
  - tag: package-2018-01-preview
  - tag: package-2018-06-preview
  - tag: package-2020-01-13-preview
```

### Tag: package-2015-10 and azureresourceschema

These settings apply only when `--tag=package-2015-10 --azureresourceschema` is specified on the command line.
Please also specify `--azureresourceschema-folder=<path to the root directory of your azure-resource-manager-schemas clone>`.

``` yaml $(tag) == 'package-2015-10' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas
```

### Tag: package-2017-05-preview and azureresourceschema

These settings apply only when `--tag=package-2017-05-preview --azureresourceschema` is specified on the command line.
Please also specify `--azureresourceschema-folder=<path to the root directory of your azure-resource-manager-schemas clone>`.

``` yaml $(tag) == 'package-2017-05-preview' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas
```

### Tag: package-2018-01-preview and azureresourceschema

These settings apply only when `--tag=package-2018-01-preview --azureresourceschema` is specified on the command line.
Please also specify `--azureresourceschema-folder=<path to the root directory of your azure-resource-manager-schemas clone>`.

``` yaml $(tag) == 'package-2018-01-preview' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas
```

### Tag: package-2018-06-preview and azureresourceschema

These settings apply only when `--tag=package-2018-06-preview --azureresourceschema` is specified on the command line.
Please also specify `--azureresourceschema-folder=<path to the root directory of your azure-resource-manager-schemas clone>`.

``` yaml $(tag) == 'package-2018-06-preview' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas
```

### Tag: package-2020-01-13-preview and azureresourceschema

These settings apply only when `--tag=package-2020-01-13-preview --azureresourceschema` is specified on the command line.
Please also specify `--azureresourceschema-folder=<path to the root directory of your azure-resource-manager-schemas clone>`.

``` yaml $(tag) == 'package-2020-01-13-preview' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas
```


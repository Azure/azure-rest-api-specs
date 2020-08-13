## AzureResourceSchema

These settings apply only when `--azureresourceschema` is specified on the command line.

### AzureResourceSchema multi-api

``` yaml $(azureresourceschema) && $(multiapi)
batch:
  - tag: package-2019-06-preview
  - tag: package-2019-06
  - tag: package-2019-03
  - tag: package-preview-2019-05
  - tag: package-2018-05
  - tag: package-2018-05-preview
```

### Tag: package-2019-06-preview and azureresourceschema

These settings apply only when `--tag=package-2019-06-preview --azureresourceschema` is specified on the command line.
Please also specify `--azureresourceschema-folder=<path to the root directory of your azure-resource-manager-schemas clone>`.

``` yaml $(tag) == 'package-2019-06-preview' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas
```

### Tag: package-2019-06 and azureresourceschema

These settings apply only when `--tag=package-2019-06 --azureresourceschema` is specified on the command line.
Please also specify `--azureresourceschema-folder=<path to the root directory of your azure-resource-manager-schemas clone>`.

``` yaml $(tag) == 'package-2019-06' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas
```

### Tag: package-2019-03 and azureresourceschema

These settings apply only when `--tag=package-2019-03 --azureresourceschema` is specified on the command line.
Please also specify `--azureresourceschema-folder=<path to the root directory of your azure-resource-manager-schemas clone>`.

``` yaml $(tag) == 'package-2019-03' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas
```

### Tag: package-preview-2019-05 and azureresourceschema

These settings apply only when `--tag=package-preview-2019-05 --azureresourceschema` is specified on the command line.
Please also specify `--azureresourceschema-folder=<path to the root directory of your azure-resource-manager-schemas clone>`.

``` yaml $(tag) == 'package-preview-2019-05' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas
```

### Tag: package-2018-05 and azureresourceschema

These settings apply only when `--tag=package-2018-05 --azureresourceschema` is specified on the command line.
Please also specify `--azureresourceschema-folder=<path to the root directory of your azure-resource-manager-schemas clone>`.

``` yaml $(tag) == 'package-2018-05' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas
```

### Tag: package-2018-05-preview and azureresourceschema

These settings apply only when `--tag=package-2018-05-preview --azureresourceschema` is specified on the command line.
Please also specify `--azureresourceschema-folder=<path to the root directory of your azure-resource-manager-schemas clone>`.

``` yaml $(tag) == 'package-2018-05-preview' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas
```


## AzureResourceSchema

These settings apply only when `--azureresourceschema` is specified on the command line.

### AzureResourceSchema multi-api

``` yaml $(azureresourceschema) && $(multiapi)
batch:
  - tag: package-2020-05-15
  - tag: package-2018-08-preview
  - tag: package-2017-11-15
  - tag: package-2017-02-preview
```

### Tag: package-2020-05-15 and azureresourceschema

These settings apply only when `--tag=package-2020-05-15 --azureresourceschema` is specified on the command line.
Please also specify `--azureresourceschema-folder=<path to the root directory of your azure-resource-manager-schemas clone>`.

``` yaml $(tag) == 'package-2020-05-15' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas
```

### Tag: package-2018-08-preview and azureresourceschema

These settings apply only when `--tag=package-2018-08-preview --azureresourceschema` is specified on the command line.
Please also specify `--azureresourceschema-folder=<path to the root directory of your azure-resource-manager-schemas clone>`.

``` yaml $(tag) == 'package-2018-08-preview' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas
```

### Tag: package-2017-11-15 and azureresourceschema

These settings apply only when `--tag=package-2017-11-15 --azureresourceschema` is specified on the command line.
Please also specify `--azureresourceschema-folder=<path to the root directory of your azure-resource-manager-schemas clone>`.

``` yaml $(tag) == 'package-2017-11-15' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas
```

### Tag: package-2017-02-preview and azureresourceschema

These settings apply only when `--tag=package-2017-02-preview --azureresourceschema` is specified on the command line.
Please also specify `--azureresourceschema-folder=<path to the root directory of your azure-resource-manager-schemas clone>`.

``` yaml $(tag) == 'package-2017-02-preview' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas
```


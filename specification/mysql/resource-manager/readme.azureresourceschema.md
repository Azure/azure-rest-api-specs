## AzureResourceSchema

These settings apply only when `--azureresourceschema` is specified on the command line.

### AzureResourceSchema multi-api

``` yaml $(azureresourceschema) && $(multiapi)
batch:
  - tag: package-2017-12-01-preview
  - tag: package-2017-12-01
  - tag: package-2018-06-01-privatepreview
  - tag: package-2018-06-01
  - tag: package-2020-01-01-privatepreview
  - tag: package-2020-01-01
  - tag: package-2020-07-01-privatepreview
```

### Tag: package-2017-12-01-preview and azureresourceschema

These settings apply only when `--tag=package-2017-12-01-preview --azureresourceschema` is specified on the command line.
Please also specify `--azureresourceschema-folder=<path to the root directory of your azure-resource-manager-schemas clone>`.

``` yaml $(tag) == 'package-2017-12-01-preview' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas
```

### Tag: package-2017-12-01 and azureresourceschema

These settings apply only when `--tag=package-2017-12-01 --azureresourceschema` is specified on the command line.
Please also specify `--azureresourceschema-folder=<path to the root directory of your azure-resource-manager-schemas clone>`.

``` yaml $(tag) == 'package-2017-12-01' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas
```

### Tag: package-2018-06-01-privatepreview and azureresourceschema

These settings apply only when `--tag=package-2018-06-01-privatepreview --azureresourceschema` is specified on the command line.
Please also specify `--azureresourceschema-folder=<path to the root directory of your azure-resource-manager-schemas clone>`.

``` yaml $(tag) == 'package-2018-06-01-privatepreview' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas
```

### Tag: package-2018-06-01 and azureresourceschema

These settings apply only when `--tag=package-2018-06-01 --azureresourceschema` is specified on the command line.
Please also specify `--azureresourceschema-folder=<path to the root directory of your azure-resource-manager-schemas clone>`.

``` yaml $(tag) == 'package-2018-06-01' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas
```

### Tag: package-2020-01-01-privatepreview and azureresourceschema

These settings apply only when `--tag=package-2020-01-01-privatepreview --azureresourceschema` is specified on the command line.
Please also specify `--azureresourceschema-folder=<path to the root directory of your azure-resource-manager-schemas clone>`.

``` yaml $(tag) == 'package-2020-01-01-privatepreview' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas
```

### Tag: package-2020-01-01 and azureresourceschema

These settings apply only when `--tag=package-2020-01-01 --azureresourceschema` is specified on the command line.
Please also specify `--azureresourceschema-folder=<path to the root directory of your azure-resource-manager-schemas clone>`.

``` yaml $(tag) == 'package-2020-01-01' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas
```

### Tag: package-2020-07-01-privatepreview and azureresourceschema

These settings apply only when `--tag=package-2020-07-01-privatepreview --azureresourceschema` is specified on the command line.
Please also specify `--azureresourceschema-folder=<path to the root directory of your azure-resource-manager-schemas clone>`.

``` yaml $(tag) == 'package-2020-07-01-privatepreview' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas
```


## AzureResourceSchema

These settings apply only when `--azureresourceschema` is specified on the command line.

### AzureResourceSchema multi-api

``` yaml $(azureresourceschema) && $(multiapi)
batch:
  - tag: package-2018-05
  - tag: package-2018-03-preview
  - tag: package-2017-10
  - tag: package-2017-09
  - tag: package-2016-04
  - tag: package-2015-05-preview
  - tag: profile-hybrid-2019-03-01
```

### Tag: package-2018-05 and azureresourceschema

These settings apply only when `--tag=package-2018-05 --azureresourceschema` is specified on the command line.
Please also specify `--azureresourceschema-folder=<path to the root directory of your azure-resource-manager-schemas clone>`.

``` yaml $(tag) == 'package-2018-05' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas
```

### Tag: package-2018-03-preview and azureresourceschema

These settings apply only when `--tag=package-2018-03-preview --azureresourceschema` is specified on the command line.
Please also specify `--azureresourceschema-folder=<path to the root directory of your azure-resource-manager-schemas clone>`.

``` yaml $(tag) == 'package-2018-03-preview' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas
```

### Tag: package-2017-10 and azureresourceschema

These settings apply only when `--tag=package-2017-10 --azureresourceschema` is specified on the command line.
Please also specify `--azureresourceschema-folder=<path to the root directory of your azure-resource-manager-schemas clone>`.

``` yaml $(tag) == 'package-2017-10' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas
```

### Tag: package-2017-09 and azureresourceschema

These settings apply only when `--tag=package-2017-09 --azureresourceschema` is specified on the command line.
Please also specify `--azureresourceschema-folder=<path to the root directory of your azure-resource-manager-schemas clone>`.

``` yaml $(tag) == 'package-2017-09' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas
```

### Tag: package-2016-04 and azureresourceschema

These settings apply only when `--tag=package-2016-04 --azureresourceschema` is specified on the command line.
Please also specify `--azureresourceschema-folder=<path to the root directory of your azure-resource-manager-schemas clone>`.

``` yaml $(tag) == 'package-2016-04' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas
```

### Tag: package-2015-05-preview and azureresourceschema

These settings apply only when `--tag=package-2015-05-preview --azureresourceschema` is specified on the command line.
Please also specify `--azureresourceschema-folder=<path to the root directory of your azure-resource-manager-schemas clone>`.

``` yaml $(tag) == 'package-2015-05-preview' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas
```

### Tag: profile-hybrid-2019-03-01 and azureresourceschema

These settings apply only when `--tag=profile-hybrid-2019-03-01 --azureresourceschema` is specified on the command line.
Please also specify `--azureresourceschema-folder=<path to the root directory of your azure-resource-manager-schemas clone>`.

``` yaml $(tag) == 'profile-hybrid-2019-03-01' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas
```


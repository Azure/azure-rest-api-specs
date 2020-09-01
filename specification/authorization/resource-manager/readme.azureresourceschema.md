## AzureResourceSchema

These settings apply only when `--azureresourceschema` is specified on the command line.

### AzureResourceSchema multi-api

``` yaml $(azureresourceschema) && $(multiapi)
batch:
  - tag: package-2020-04-preview
  - tag: package-2015-07-01
  - tag: package-2015-06-01-preview
  - tag: package-2017-10-01-preview-only
  - tag: package-2018-01-01-preview-only
  - tag: package-2018-07-01-preview-only
  - tag: package-2018-09-01-preview-only
  - tag: package-2017-10-01-preview
  - tag: package-2018-01-01-preview
  - tag: package-2018-07-01-preview
  - tag: package-2018-09-01-preview
  - tag: profile-hybrid-2019-03-01
```

### Tag: package-2020-04-preview and azureresourceschema

These settings apply only when `--tag=package-2020-04-preview --azureresourceschema` is specified on the command line.
Please also specify `--azureresourceschema-folder=<path to the root directory of your azure-resource-manager-schemas clone>`.

``` yaml $(tag) == 'package-2020-04-preview' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas
```

### Tag: package-2015-07-01 and azureresourceschema

These settings apply only when `--tag=package-2015-07-01 --azureresourceschema` is specified on the command line.
Please also specify `--azureresourceschema-folder=<path to the root directory of your azure-resource-manager-schemas clone>`.

``` yaml $(tag) == 'package-2015-07-01' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas
```

### Tag: package-2015-06-01-preview and azureresourceschema

These settings apply only when `--tag=package-2015-06-01-preview --azureresourceschema` is specified on the command line.
Please also specify `--azureresourceschema-folder=<path to the root directory of your azure-resource-manager-schemas clone>`.

``` yaml $(tag) == 'package-2015-06-01-preview' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas
```

### Tag: package-2017-10-01-preview-only and azureresourceschema

These settings apply only when `--tag=package-2017-10-01-preview-only --azureresourceschema` is specified on the command line.
Please also specify `--azureresourceschema-folder=<path to the root directory of your azure-resource-manager-schemas clone>`.

``` yaml $(tag) == 'package-2017-10-01-preview-only' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas
```

### Tag: package-2018-01-01-preview-only and azureresourceschema

These settings apply only when `--tag=package-2018-01-01-preview-only --azureresourceschema` is specified on the command line.
Please also specify `--azureresourceschema-folder=<path to the root directory of your azure-resource-manager-schemas clone>`.

``` yaml $(tag) == 'package-2018-01-01-preview-only' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas
```

### Tag: package-2018-07-01-preview-only and azureresourceschema

These settings apply only when `--tag=package-2018-07-01-preview-only --azureresourceschema` is specified on the command line.
Please also specify `--azureresourceschema-folder=<path to the root directory of your azure-resource-manager-schemas clone>`.

``` yaml $(tag) == 'package-2018-07-01-preview-only' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas
```

### Tag: package-2018-09-01-preview-only and azureresourceschema

These settings apply only when `--tag=package-2018-09-01-preview-only --azureresourceschema` is specified on the command line.
Please also specify `--azureresourceschema-folder=<path to the root directory of your azure-resource-manager-schemas clone>`.

``` yaml $(tag) == 'package-2018-09-01-preview-only' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas
```

### Tag: package-2017-10-01-preview and azureresourceschema

These settings apply only when `--tag=package-2017-10-01-preview --azureresourceschema` is specified on the command line.
Please also specify `--azureresourceschema-folder=<path to the root directory of your azure-resource-manager-schemas clone>`.

``` yaml $(tag) == 'package-2017-10-01-preview' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas
```

### Tag: package-2018-01-01-preview and azureresourceschema

These settings apply only when `--tag=package-2018-01-01-preview --azureresourceschema` is specified on the command line.
Please also specify `--azureresourceschema-folder=<path to the root directory of your azure-resource-manager-schemas clone>`.

``` yaml $(tag) == 'package-2018-01-01-preview' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas
```

### Tag: package-2018-07-01-preview and azureresourceschema

These settings apply only when `--tag=package-2018-07-01-preview --azureresourceschema` is specified on the command line.
Please also specify `--azureresourceschema-folder=<path to the root directory of your azure-resource-manager-schemas clone>`.

``` yaml $(tag) == 'package-2018-07-01-preview' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas
```

### Tag: package-2018-09-01-preview and azureresourceschema

These settings apply only when `--tag=package-2018-09-01-preview --azureresourceschema` is specified on the command line.
Please also specify `--azureresourceschema-folder=<path to the root directory of your azure-resource-manager-schemas clone>`.

``` yaml $(tag) == 'package-2018-09-01-preview' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas
```

### Tag: profile-hybrid-2019-03-01 and azureresourceschema

These settings apply only when `--tag=profile-hybrid-2019-03-01 --azureresourceschema` is specified on the command line.
Please also specify `--azureresourceschema-folder=<path to the root directory of your azure-resource-manager-schemas clone>`.

``` yaml $(tag) == 'profile-hybrid-2019-03-01' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas
```


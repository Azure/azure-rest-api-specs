## AzureResourceSchema

These settings apply only when `--azureresourceschema` is specified on the command line.

### AzureResourceSchema multi-api

``` yaml $(azureresourceschema) && $(multiapi)
batch:
  - tag: package-composite-v3
  - tag: package-composite-v2
  - tag: package-composite-v1
  - tag: package-2017-03-preview
  - tag: package-2015-05-preview
  - tag: package-2014-04
  - tag: package-pure-2020-02-preview
  - tag: package-pure-2019-06-preview
  - tag: package-pure-2018-06-preview
  - tag: package-pure-2017-10-preview
  - tag: package-pure-2017-03-preview
  - tag: package-pure-2015-05-preview
  - tag: package-pure-2014-04
```

### Tag: package-composite-v3 and azureresourceschema

These settings apply only when `--tag=package-composite-v3 --azureresourceschema` is specified on the command line.
Please also specify `--azureresourceschema-folder=<path to the root directory of your azure-resource-manager-schemas clone>`.

``` yaml $(tag) == 'package-composite-v3' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas
```

### Tag: package-composite-v2 and azureresourceschema

These settings apply only when `--tag=package-composite-v2 --azureresourceschema` is specified on the command line.
Please also specify `--azureresourceschema-folder=<path to the root directory of your azure-resource-manager-schemas clone>`.

``` yaml $(tag) == 'package-composite-v2' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas
```

### Tag: package-composite-v1 and azureresourceschema

These settings apply only when `--tag=package-composite-v1 --azureresourceschema` is specified on the command line.
Please also specify `--azureresourceschema-folder=<path to the root directory of your azure-resource-manager-schemas clone>`.

``` yaml $(tag) == 'package-composite-v1' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas
```

### Tag: package-2017-03-preview and azureresourceschema

These settings apply only when `--tag=package-2017-03-preview --azureresourceschema` is specified on the command line.
Please also specify `--azureresourceschema-folder=<path to the root directory of your azure-resource-manager-schemas clone>`.

``` yaml $(tag) == 'package-2017-03-preview' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas
```

### Tag: package-2015-05-preview and azureresourceschema

These settings apply only when `--tag=package-2015-05-preview --azureresourceschema` is specified on the command line.
Please also specify `--azureresourceschema-folder=<path to the root directory of your azure-resource-manager-schemas clone>`.

``` yaml $(tag) == 'package-2015-05-preview' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas
```

### Tag: package-2014-04 and azureresourceschema

These settings apply only when `--tag=package-2014-04 --azureresourceschema` is specified on the command line.
Please also specify `--azureresourceschema-folder=<path to the root directory of your azure-resource-manager-schemas clone>`.

``` yaml $(tag) == 'package-2014-04' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas
```

### Tag: package-pure-2020-02-preview and azureresourceschema

These settings apply only when `--tag=package-pure-2020-02-preview --azureresourceschema` is specified on the command line.
Please also specify `--azureresourceschema-folder=<path to the root directory of your azure-resource-manager-schemas clone>`.

``` yaml $(tag) == 'package-pure-2020-02-preview' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas
```

### Tag: package-pure-2019-06-preview and azureresourceschema

These settings apply only when `--tag=package-pure-2019-06-preview --azureresourceschema` is specified on the command line.
Please also specify `--azureresourceschema-folder=<path to the root directory of your azure-resource-manager-schemas clone>`.

``` yaml $(tag) == 'package-pure-2019-06-preview' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas
```

### Tag: package-pure-2018-06-preview and azureresourceschema

These settings apply only when `--tag=package-pure-2018-06-preview --azureresourceschema` is specified on the command line.
Please also specify `--azureresourceschema-folder=<path to the root directory of your azure-resource-manager-schemas clone>`.

``` yaml $(tag) == 'package-pure-2018-06-preview' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas
```

### Tag: package-pure-2017-10-preview and azureresourceschema

These settings apply only when `--tag=package-pure-2017-10-preview --azureresourceschema` is specified on the command line.
Please also specify `--azureresourceschema-folder=<path to the root directory of your azure-resource-manager-schemas clone>`.

``` yaml $(tag) == 'package-pure-2017-10-preview' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas
```

### Tag: package-pure-2017-03-preview and azureresourceschema

These settings apply only when `--tag=package-pure-2017-03-preview --azureresourceschema` is specified on the command line.
Please also specify `--azureresourceschema-folder=<path to the root directory of your azure-resource-manager-schemas clone>`.

``` yaml $(tag) == 'package-pure-2017-03-preview' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas
```

### Tag: package-pure-2015-05-preview and azureresourceschema

These settings apply only when `--tag=package-pure-2015-05-preview --azureresourceschema` is specified on the command line.
Please also specify `--azureresourceschema-folder=<path to the root directory of your azure-resource-manager-schemas clone>`.

``` yaml $(tag) == 'package-pure-2015-05-preview' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas
```

### Tag: package-pure-2014-04 and azureresourceschema

These settings apply only when `--tag=package-pure-2014-04 --azureresourceschema` is specified on the command line.
Please also specify `--azureresourceschema-folder=<path to the root directory of your azure-resource-manager-schemas clone>`.

``` yaml $(tag) == 'package-pure-2014-04' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas
```


## AzureResourceSchema

These settings apply only when `--azureresourceschema` is specified on the command line.

### AzureResourceSchema multi-api

``` yaml $(azureresourceschema) && $(multiapi)
batch:
  - tag: package-2020-06-01
  - tag: package-2020-06-01-only
  - tag: package-2020-05-01
  - tag: package-2020-05-01-only
  - tag: package-2019-12-01
  - tag: package-2019-12-01-only
  - tag: package-2019-11-01
  - tag: package-2019-11-01-only
  - tag: package-2019-07
  - tag: package-2019-07-01
  - tag: package-2019-07-01-only
  - tag: package-2019-03-01
  - tag: package-2019-04-01-only
  - tag: package-2019-03-01-only
  - tag: package-2018-10-01-Disks
  - tag: package-2018-10-01
  - tag: package-2018-10-01-only
  - tag: package-2018-09-30-only
  - tag: package-2018-06-exclude-gallery
  - tag: package-2018-06
  - tag: package-2018-06-01
  - tag: package-compute-only-2018-06
  - tag: package-2018-04-01
  - tag: package-2018-04
  - tag: package-compute-2018-04
  - tag: package-disks-2018-04
  - tag: package-2017-12
  - tag: package-compute-2017-12
  - tag: package-compute-only-2017-12
  - tag: package-skus-2017-09
  - tag: package-2017-03
  - tag: package-compute-2017-03
  - tag: package-container-service-2017-01
  - tag: package-container-service-2016-09
  - tag: package-2016-04-preview
  - tag: package-compute-2016-04-preview
  - tag: package-2016-03
  - tag: package-compute-2016-03
  - tag: package-container-service-2016-03
  - tag: package-container-service-2015-11-preview
  - tag: package-compute-2015-06
  - tag: package-2015-06-preview
  - tag: profile-hybrid-2019-03-01
```

### Tag: package-2020-06-01 and azureresourceschema

These settings apply only when `--tag=package-2020-06-01 --azureresourceschema` is specified on the command line.
Please also specify `--azureresourceschema-folder=<path to the root directory of your azure-resource-manager-schemas clone>`.

``` yaml $(tag) == 'package-2020-06-01' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas
```

### Tag: package-2020-06-01-only and azureresourceschema

These settings apply only when `--tag=package-2020-06-01-only --azureresourceschema` is specified on the command line.
Please also specify `--azureresourceschema-folder=<path to the root directory of your azure-resource-manager-schemas clone>`.

``` yaml $(tag) == 'package-2020-06-01-only' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas
```

### Tag: package-2020-05-01 and azureresourceschema

These settings apply only when `--tag=package-2020-05-01 --azureresourceschema` is specified on the command line.
Please also specify `--azureresourceschema-folder=<path to the root directory of your azure-resource-manager-schemas clone>`.

``` yaml $(tag) == 'package-2020-05-01' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas
```

### Tag: package-2020-05-01-only and azureresourceschema

These settings apply only when `--tag=package-2020-05-01-only --azureresourceschema` is specified on the command line.
Please also specify `--azureresourceschema-folder=<path to the root directory of your azure-resource-manager-schemas clone>`.

``` yaml $(tag) == 'package-2020-05-01-only' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas
```

### Tag: package-2019-12-01 and azureresourceschema

These settings apply only when `--tag=package-2019-12-01 --azureresourceschema` is specified on the command line.
Please also specify `--azureresourceschema-folder=<path to the root directory of your azure-resource-manager-schemas clone>`.

``` yaml $(tag) == 'package-2019-12-01' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas
```

### Tag: package-2019-12-01-only and azureresourceschema

These settings apply only when `--tag=package-2019-12-01-only --azureresourceschema` is specified on the command line.
Please also specify `--azureresourceschema-folder=<path to the root directory of your azure-resource-manager-schemas clone>`.

``` yaml $(tag) == 'package-2019-12-01-only' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas
```

### Tag: package-2019-11-01 and azureresourceschema

These settings apply only when `--tag=package-2019-11-01 --azureresourceschema` is specified on the command line.
Please also specify `--azureresourceschema-folder=<path to the root directory of your azure-resource-manager-schemas clone>`.

``` yaml $(tag) == 'package-2019-11-01' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas
```

### Tag: package-2019-11-01-only and azureresourceschema

These settings apply only when `--tag=package-2019-11-01-only --azureresourceschema` is specified on the command line.
Please also specify `--azureresourceschema-folder=<path to the root directory of your azure-resource-manager-schemas clone>`.

``` yaml $(tag) == 'package-2019-11-01-only' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas
```

### Tag: package-2019-07 and azureresourceschema

These settings apply only when `--tag=package-2019-07 --azureresourceschema` is specified on the command line.
Please also specify `--azureresourceschema-folder=<path to the root directory of your azure-resource-manager-schemas clone>`.

``` yaml $(tag) == 'package-2019-07' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas
```

### Tag: package-2019-07-01 and azureresourceschema

These settings apply only when `--tag=package-2019-07-01 --azureresourceschema` is specified on the command line.
Please also specify `--azureresourceschema-folder=<path to the root directory of your azure-resource-manager-schemas clone>`.

``` yaml $(tag) == 'package-2019-07-01' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas
```

### Tag: package-2019-07-01-only and azureresourceschema

These settings apply only when `--tag=package-2019-07-01-only --azureresourceschema` is specified on the command line.
Please also specify `--azureresourceschema-folder=<path to the root directory of your azure-resource-manager-schemas clone>`.

``` yaml $(tag) == 'package-2019-07-01-only' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas
```

### Tag: package-2019-03-01 and azureresourceschema

These settings apply only when `--tag=package-2019-03-01 --azureresourceschema` is specified on the command line.
Please also specify `--azureresourceschema-folder=<path to the root directory of your azure-resource-manager-schemas clone>`.

``` yaml $(tag) == 'package-2019-03-01' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas
```

### Tag: package-2019-04-01-only and azureresourceschema

These settings apply only when `--tag=package-2019-04-01-only --azureresourceschema` is specified on the command line.
Please also specify `--azureresourceschema-folder=<path to the root directory of your azure-resource-manager-schemas clone>`.

``` yaml $(tag) == 'package-2019-04-01-only' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas
```

### Tag: package-2019-03-01-only and azureresourceschema

These settings apply only when `--tag=package-2019-03-01-only --azureresourceschema` is specified on the command line.
Please also specify `--azureresourceschema-folder=<path to the root directory of your azure-resource-manager-schemas clone>`.

``` yaml $(tag) == 'package-2019-03-01-only' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas
```

### Tag: package-2018-10-01-Disks and azureresourceschema

These settings apply only when `--tag=package-2018-10-01-Disks --azureresourceschema` is specified on the command line.
Please also specify `--azureresourceschema-folder=<path to the root directory of your azure-resource-manager-schemas clone>`.

``` yaml $(tag) == 'package-2018-10-01-Disks' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas
```

### Tag: package-2018-10-01 and azureresourceschema

These settings apply only when `--tag=package-2018-10-01 --azureresourceschema` is specified on the command line.
Please also specify `--azureresourceschema-folder=<path to the root directory of your azure-resource-manager-schemas clone>`.

``` yaml $(tag) == 'package-2018-10-01' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas
```

### Tag: package-2018-10-01-only and azureresourceschema

These settings apply only when `--tag=package-2018-10-01-only --azureresourceschema` is specified on the command line.
Please also specify `--azureresourceschema-folder=<path to the root directory of your azure-resource-manager-schemas clone>`.

``` yaml $(tag) == 'package-2018-10-01-only' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas
```

### Tag: package-2018-09-30-only and azureresourceschema

These settings apply only when `--tag=package-2018-09-30-only --azureresourceschema` is specified on the command line.
Please also specify `--azureresourceschema-folder=<path to the root directory of your azure-resource-manager-schemas clone>`.

``` yaml $(tag) == 'package-2018-09-30-only' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas
```

### Tag: package-2018-06-exclude-gallery and azureresourceschema

These settings apply only when `--tag=package-2018-06-exclude-gallery --azureresourceschema` is specified on the command line.
Please also specify `--azureresourceschema-folder=<path to the root directory of your azure-resource-manager-schemas clone>`.

``` yaml $(tag) == 'package-2018-06-exclude-gallery' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas
```

### Tag: package-2018-06 and azureresourceschema

These settings apply only when `--tag=package-2018-06 --azureresourceschema` is specified on the command line.
Please also specify `--azureresourceschema-folder=<path to the root directory of your azure-resource-manager-schemas clone>`.

``` yaml $(tag) == 'package-2018-06' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas
```

### Tag: package-2018-06-01 and azureresourceschema

These settings apply only when `--tag=package-2018-06-01 --azureresourceschema` is specified on the command line.
Please also specify `--azureresourceschema-folder=<path to the root directory of your azure-resource-manager-schemas clone>`.

``` yaml $(tag) == 'package-2018-06-01' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas
```

### Tag: package-compute-only-2018-06 and azureresourceschema

These settings apply only when `--tag=package-compute-only-2018-06 --azureresourceschema` is specified on the command line.
Please also specify `--azureresourceschema-folder=<path to the root directory of your azure-resource-manager-schemas clone>`.

``` yaml $(tag) == 'package-compute-only-2018-06' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas
```

### Tag: package-2018-04-01 and azureresourceschema

These settings apply only when `--tag=package-2018-04-01 --azureresourceschema` is specified on the command line.
Please also specify `--azureresourceschema-folder=<path to the root directory of your azure-resource-manager-schemas clone>`.

``` yaml $(tag) == 'package-2018-04-01' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas
```

### Tag: package-2018-04 and azureresourceschema

These settings apply only when `--tag=package-2018-04 --azureresourceschema` is specified on the command line.
Please also specify `--azureresourceschema-folder=<path to the root directory of your azure-resource-manager-schemas clone>`.

``` yaml $(tag) == 'package-2018-04' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas
```

### Tag: package-compute-2018-04 and azureresourceschema

These settings apply only when `--tag=package-compute-2018-04 --azureresourceschema` is specified on the command line.
Please also specify `--azureresourceschema-folder=<path to the root directory of your azure-resource-manager-schemas clone>`.

``` yaml $(tag) == 'package-compute-2018-04' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas
```

### Tag: package-disks-2018-04 and azureresourceschema

These settings apply only when `--tag=package-disks-2018-04 --azureresourceschema` is specified on the command line.
Please also specify `--azureresourceschema-folder=<path to the root directory of your azure-resource-manager-schemas clone>`.

``` yaml $(tag) == 'package-disks-2018-04' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas
```

### Tag: package-2017-12 and azureresourceschema

These settings apply only when `--tag=package-2017-12 --azureresourceschema` is specified on the command line.
Please also specify `--azureresourceschema-folder=<path to the root directory of your azure-resource-manager-schemas clone>`.

``` yaml $(tag) == 'package-2017-12' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas
```

### Tag: package-compute-2017-12 and azureresourceschema

These settings apply only when `--tag=package-compute-2017-12 --azureresourceschema` is specified on the command line.
Please also specify `--azureresourceschema-folder=<path to the root directory of your azure-resource-manager-schemas clone>`.

``` yaml $(tag) == 'package-compute-2017-12' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas
```

### Tag: package-compute-only-2017-12 and azureresourceschema

These settings apply only when `--tag=package-compute-only-2017-12 --azureresourceschema` is specified on the command line.
Please also specify `--azureresourceschema-folder=<path to the root directory of your azure-resource-manager-schemas clone>`.

``` yaml $(tag) == 'package-compute-only-2017-12' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas
```

### Tag: package-skus-2017-09 and azureresourceschema

These settings apply only when `--tag=package-skus-2017-09 --azureresourceschema` is specified on the command line.
Please also specify `--azureresourceschema-folder=<path to the root directory of your azure-resource-manager-schemas clone>`.

``` yaml $(tag) == 'package-skus-2017-09' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas
```

### Tag: package-2017-03 and azureresourceschema

These settings apply only when `--tag=package-2017-03 --azureresourceschema` is specified on the command line.
Please also specify `--azureresourceschema-folder=<path to the root directory of your azure-resource-manager-schemas clone>`.

``` yaml $(tag) == 'package-2017-03' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas
```

### Tag: package-compute-2017-03 and azureresourceschema

These settings apply only when `--tag=package-compute-2017-03 --azureresourceschema` is specified on the command line.
Please also specify `--azureresourceschema-folder=<path to the root directory of your azure-resource-manager-schemas clone>`.

``` yaml $(tag) == 'package-compute-2017-03' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas
```

### Tag: package-container-service-2017-01 and azureresourceschema

These settings apply only when `--tag=package-container-service-2017-01 --azureresourceschema` is specified on the command line.
Please also specify `--azureresourceschema-folder=<path to the root directory of your azure-resource-manager-schemas clone>`.

``` yaml $(tag) == 'package-container-service-2017-01' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas
```

### Tag: package-container-service-2016-09 and azureresourceschema

These settings apply only when `--tag=package-container-service-2016-09 --azureresourceschema` is specified on the command line.
Please also specify `--azureresourceschema-folder=<path to the root directory of your azure-resource-manager-schemas clone>`.

``` yaml $(tag) == 'package-container-service-2016-09' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas
```

### Tag: package-2016-04-preview and azureresourceschema

These settings apply only when `--tag=package-2016-04-preview --azureresourceschema` is specified on the command line.
Please also specify `--azureresourceschema-folder=<path to the root directory of your azure-resource-manager-schemas clone>`.

``` yaml $(tag) == 'package-2016-04-preview' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas
```

### Tag: package-compute-2016-04-preview and azureresourceschema

These settings apply only when `--tag=package-compute-2016-04-preview --azureresourceschema` is specified on the command line.
Please also specify `--azureresourceschema-folder=<path to the root directory of your azure-resource-manager-schemas clone>`.

``` yaml $(tag) == 'package-compute-2016-04-preview' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas
```

### Tag: package-2016-03 and azureresourceschema

These settings apply only when `--tag=package-2016-03 --azureresourceschema` is specified on the command line.
Please also specify `--azureresourceschema-folder=<path to the root directory of your azure-resource-manager-schemas clone>`.

``` yaml $(tag) == 'package-2016-03' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas
```

### Tag: package-compute-2016-03 and azureresourceschema

These settings apply only when `--tag=package-compute-2016-03 --azureresourceschema` is specified on the command line.
Please also specify `--azureresourceschema-folder=<path to the root directory of your azure-resource-manager-schemas clone>`.

``` yaml $(tag) == 'package-compute-2016-03' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas
```

### Tag: package-container-service-2016-03 and azureresourceschema

These settings apply only when `--tag=package-container-service-2016-03 --azureresourceschema` is specified on the command line.
Please also specify `--azureresourceschema-folder=<path to the root directory of your azure-resource-manager-schemas clone>`.

``` yaml $(tag) == 'package-container-service-2016-03' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas
```

### Tag: package-container-service-2015-11-preview and azureresourceschema

These settings apply only when `--tag=package-container-service-2015-11-preview --azureresourceschema` is specified on the command line.
Please also specify `--azureresourceschema-folder=<path to the root directory of your azure-resource-manager-schemas clone>`.

``` yaml $(tag) == 'package-container-service-2015-11-preview' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas
```

### Tag: package-compute-2015-06 and azureresourceschema

These settings apply only when `--tag=package-compute-2015-06 --azureresourceschema` is specified on the command line.
Please also specify `--azureresourceschema-folder=<path to the root directory of your azure-resource-manager-schemas clone>`.

``` yaml $(tag) == 'package-compute-2015-06' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas
```

### Tag: package-2015-06-preview and azureresourceschema

These settings apply only when `--tag=package-2015-06-preview --azureresourceschema` is specified on the command line.
Please also specify `--azureresourceschema-folder=<path to the root directory of your azure-resource-manager-schemas clone>`.

``` yaml $(tag) == 'package-2015-06-preview' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas
```

### Tag: profile-hybrid-2019-03-01 and azureresourceschema

These settings apply only when `--tag=profile-hybrid-2019-03-01 --azureresourceschema` is specified on the command line.
Please also specify `--azureresourceschema-folder=<path to the root directory of your azure-resource-manager-schemas clone>`.

``` yaml $(tag) == 'profile-hybrid-2019-03-01' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas
```


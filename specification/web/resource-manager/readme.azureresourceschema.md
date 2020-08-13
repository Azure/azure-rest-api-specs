## AzureResourceSchema

These settings apply only when `--azureresourceschema` is specified on the command line.

### AzureResourceSchema multi-api

``` yaml $(azureresourceschema) && $(multiapi)
batch:
  - tag: package-2020-06
  - tag: package-2019-08
  - tag: package-2018-12
  - tag: package-2018-11
  - tag: package-2018-11-only
  - tag: package-2018-02
  - tag: package-2018-02-only
  - tag: package-2016-09
  - tag: package-2016-09-only
  - tag: package-2016-08-only
  - tag: package-2016-03-only
  - tag: package-2015-08-only
  - tag: package-2015-04-only
  - tag: package-2015-08-preview
  - tag: package-2015-08-certificate-registration
  - tag: package-2015-04-domain-registration
  - tag: package-2016-09-01-web
  - tag: package-2016-08-01-web
  - tag: package-2016-03-01-web
  - tag: package-2018-03-01-hybrid
  - tag: profile-hybrid-2019-03-01
```

### Tag: package-2020-06 and azureresourceschema

These settings apply only when `--tag=package-2020-06 --azureresourceschema` is specified on the command line.
Please also specify `--azureresourceschema-folder=<path to the root directory of your azure-resource-manager-schemas clone>`.

``` yaml $(tag) == 'package-2020-06' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas
```

### Tag: package-2019-08 and azureresourceschema

These settings apply only when `--tag=package-2019-08 --azureresourceschema` is specified on the command line.
Please also specify `--azureresourceschema-folder=<path to the root directory of your azure-resource-manager-schemas clone>`.

``` yaml $(tag) == 'package-2019-08' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas
```

### Tag: package-2018-12 and azureresourceschema

These settings apply only when `--tag=package-2018-12 --azureresourceschema` is specified on the command line.
Please also specify `--azureresourceschema-folder=<path to the root directory of your azure-resource-manager-schemas clone>`.

``` yaml $(tag) == 'package-2018-12' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas
```

### Tag: package-2018-11 and azureresourceschema

These settings apply only when `--tag=package-2018-11 --azureresourceschema` is specified on the command line.
Please also specify `--azureresourceschema-folder=<path to the root directory of your azure-resource-manager-schemas clone>`.

``` yaml $(tag) == 'package-2018-11' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas
```

### Tag: package-2018-11-only and azureresourceschema

These settings apply only when `--tag=package-2018-11-only --azureresourceschema` is specified on the command line.
Please also specify `--azureresourceschema-folder=<path to the root directory of your azure-resource-manager-schemas clone>`.

``` yaml $(tag) == 'package-2018-11-only' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas
```

### Tag: package-2018-02 and azureresourceschema

These settings apply only when `--tag=package-2018-02 --azureresourceschema` is specified on the command line.
Please also specify `--azureresourceschema-folder=<path to the root directory of your azure-resource-manager-schemas clone>`.

``` yaml $(tag) == 'package-2018-02' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas
```

### Tag: package-2018-02-only and azureresourceschema

These settings apply only when `--tag=package-2018-02-only --azureresourceschema` is specified on the command line.
Please also specify `--azureresourceschema-folder=<path to the root directory of your azure-resource-manager-schemas clone>`.

``` yaml $(tag) == 'package-2018-02-only' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas
```

### Tag: package-2016-09 and azureresourceschema

These settings apply only when `--tag=package-2016-09 --azureresourceschema` is specified on the command line.
Please also specify `--azureresourceschema-folder=<path to the root directory of your azure-resource-manager-schemas clone>`.

``` yaml $(tag) == 'package-2016-09' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas
```

### Tag: package-2016-09-only and azureresourceschema

These settings apply only when `--tag=package-2016-09-only --azureresourceschema` is specified on the command line.
Please also specify `--azureresourceschema-folder=<path to the root directory of your azure-resource-manager-schemas clone>`.

``` yaml $(tag) == 'package-2016-09-only' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas
```

### Tag: package-2016-08-only and azureresourceschema

These settings apply only when `--tag=package-2016-08-only --azureresourceschema` is specified on the command line.
Please also specify `--azureresourceschema-folder=<path to the root directory of your azure-resource-manager-schemas clone>`.

``` yaml $(tag) == 'package-2016-08-only' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas
```

### Tag: package-2016-03-only and azureresourceschema

These settings apply only when `--tag=package-2016-03-only --azureresourceschema` is specified on the command line.
Please also specify `--azureresourceschema-folder=<path to the root directory of your azure-resource-manager-schemas clone>`.

``` yaml $(tag) == 'package-2016-03-only' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas
```

### Tag: package-2015-08-only and azureresourceschema

These settings apply only when `--tag=package-2015-08-only --azureresourceschema` is specified on the command line.
Please also specify `--azureresourceschema-folder=<path to the root directory of your azure-resource-manager-schemas clone>`.

``` yaml $(tag) == 'package-2015-08-only' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas
```

### Tag: package-2015-04-only and azureresourceschema

These settings apply only when `--tag=package-2015-04-only --azureresourceschema` is specified on the command line.
Please also specify `--azureresourceschema-folder=<path to the root directory of your azure-resource-manager-schemas clone>`.

``` yaml $(tag) == 'package-2015-04-only' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas
```

### Tag: package-2015-08-preview and azureresourceschema

These settings apply only when `--tag=package-2015-08-preview --azureresourceschema` is specified on the command line.
Please also specify `--azureresourceschema-folder=<path to the root directory of your azure-resource-manager-schemas clone>`.

``` yaml $(tag) == 'package-2015-08-preview' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas
```

### Tag: package-2015-08-certificate-registration and azureresourceschema

These settings apply only when `--tag=package-2015-08-certificate-registration --azureresourceschema` is specified on the command line.
Please also specify `--azureresourceschema-folder=<path to the root directory of your azure-resource-manager-schemas clone>`.

``` yaml $(tag) == 'package-2015-08-certificate-registration' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas
```

### Tag: package-2015-04-domain-registration and azureresourceschema

These settings apply only when `--tag=package-2015-04-domain-registration --azureresourceschema` is specified on the command line.
Please also specify `--azureresourceschema-folder=<path to the root directory of your azure-resource-manager-schemas clone>`.

``` yaml $(tag) == 'package-2015-04-domain-registration' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas
```

### Tag: package-2016-09-01-web and azureresourceschema

These settings apply only when `--tag=package-2016-09-01-web --azureresourceschema` is specified on the command line.
Please also specify `--azureresourceschema-folder=<path to the root directory of your azure-resource-manager-schemas clone>`.

``` yaml $(tag) == 'package-2016-09-01-web' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas
```

### Tag: package-2016-08-01-web and azureresourceschema

These settings apply only when `--tag=package-2016-08-01-web --azureresourceschema` is specified on the command line.
Please also specify `--azureresourceschema-folder=<path to the root directory of your azure-resource-manager-schemas clone>`.

``` yaml $(tag) == 'package-2016-08-01-web' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas
```

### Tag: package-2016-03-01-web and azureresourceschema

These settings apply only when `--tag=package-2016-03-01-web --azureresourceschema` is specified on the command line.
Please also specify `--azureresourceschema-folder=<path to the root directory of your azure-resource-manager-schemas clone>`.

``` yaml $(tag) == 'package-2016-03-01-web' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas
```

### Tag: package-2018-03-01-hybrid and azureresourceschema

These settings apply only when `--tag=package-2018-03-01-hybrid --azureresourceschema` is specified on the command line.
Please also specify `--azureresourceschema-folder=<path to the root directory of your azure-resource-manager-schemas clone>`.

``` yaml $(tag) == 'package-2018-03-01-hybrid' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas
```

### Tag: profile-hybrid-2019-03-01 and azureresourceschema

These settings apply only when `--tag=profile-hybrid-2019-03-01 --azureresourceschema` is specified on the command line.
Please also specify `--azureresourceschema-folder=<path to the root directory of your azure-resource-manager-schemas clone>`.

``` yaml $(tag) == 'profile-hybrid-2019-03-01' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas
```


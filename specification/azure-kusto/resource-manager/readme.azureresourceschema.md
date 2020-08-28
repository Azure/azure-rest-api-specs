## AzureResourceSchema

These settings apply only when `--azureresourceschema` is specified on the command line.

### AzureResourceSchema multi-api

``` yaml $(azureresourceschema) && $(multiapi)
batch:
  - tag: package-2020-06-14
  - tag: package-2020-02-15
  - tag: package-2019-11-09
  - tag: package-2019-09-07
  - tag: package-2019-05-15
  - tag: package-2019-01-21
  - tag: package-2018-09-07-preview
  - tag: schema-2019-09-07
  - tag: schema-2019-05-15
  - tag: schema-2019-01-21
  - tag: schema-2018-09-07-preview
```

### Tag: package-2020-06-14 and azureresourceschema

These settings apply only when `--tag=package-2020-06-14 --azureresourceschema` is specified on the command line.
Please also specify `--azureresourceschema-folder=<path to the root directory of your azure-resource-manager-schemas clone>`.

``` yaml $(tag) == 'package-2020-06-14' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas
```

### Tag: package-2020-02-15 and azureresourceschema

These settings apply only when `--tag=package-2020-02-15 --azureresourceschema` is specified on the command line.
Please also specify `--azureresourceschema-folder=<path to the root directory of your azure-resource-manager-schemas clone>`.

``` yaml $(tag) == 'package-2020-02-15' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas
```

### Tag: package-2019-11-09 and azureresourceschema

These settings apply only when `--tag=package-2019-11-09 --azureresourceschema` is specified on the command line.
Please also specify `--azureresourceschema-folder=<path to the root directory of your azure-resource-manager-schemas clone>`.

``` yaml $(tag) == 'package-2019-11-09' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas
```

### Tag: package-2019-09-07 and azureresourceschema

These settings apply only when `--tag=package-2019-09-07 --azureresourceschema` is specified on the command line.
Please also specify `--azureresourceschema-folder=<path to the root directory of your azure-resource-manager-schemas clone>`.

``` yaml $(tag) == 'package-2019-09-07' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas
```

### Tag: package-2019-05-15 and azureresourceschema

These settings apply only when `--tag=package-2019-05-15 --azureresourceschema` is specified on the command line.
Please also specify `--azureresourceschema-folder=<path to the root directory of your azure-resource-manager-schemas clone>`.

``` yaml $(tag) == 'package-2019-05-15' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas
```

### Tag: package-2019-01-21 and azureresourceschema

These settings apply only when `--tag=package-2019-01-21 --azureresourceschema` is specified on the command line.
Please also specify `--azureresourceschema-folder=<path to the root directory of your azure-resource-manager-schemas clone>`.

``` yaml $(tag) == 'package-2019-01-21' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas
```

### Tag: package-2018-09-07-preview and azureresourceschema

These settings apply only when `--tag=package-2018-09-07-preview --azureresourceschema` is specified on the command line.
Please also specify `--azureresourceschema-folder=<path to the root directory of your azure-resource-manager-schemas clone>`.

``` yaml $(tag) == 'package-2018-09-07-preview' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas
```

### Tag: schema-2019-09-07 and azureresourceschema

These settings apply only when `--tag=schema-2019-09-07 --azureresourceschema` is specified on the command line.
Please also specify `--azureresourceschema-folder=<path to the root directory of your azure-resource-manager-schemas clone>`.

``` yaml $(tag) == 'schema-2019-09-07' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas
```

### Tag: schema-2019-05-15 and azureresourceschema

These settings apply only when `--tag=schema-2019-05-15 --azureresourceschema` is specified on the command line.
Please also specify `--azureresourceschema-folder=<path to the root directory of your azure-resource-manager-schemas clone>`.

``` yaml $(tag) == 'schema-2019-05-15' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas
```

### Tag: schema-2019-01-21 and azureresourceschema

These settings apply only when `--tag=schema-2019-01-21 --azureresourceschema` is specified on the command line.
Please also specify `--azureresourceschema-folder=<path to the root directory of your azure-resource-manager-schemas clone>`.

``` yaml $(tag) == 'schema-2019-01-21' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas
```

### Tag: schema-2018-09-07-preview and azureresourceschema

These settings apply only when `--tag=schema-2018-09-07-preview --azureresourceschema` is specified on the command line.
Please also specify `--azureresourceschema-folder=<path to the root directory of your azure-resource-manager-schemas clone>`.

``` yaml $(tag) == 'schema-2018-09-07-preview' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas
```

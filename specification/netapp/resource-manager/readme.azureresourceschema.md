## AzureResourceSchema

These settings apply only when `--azureresourceschema` is specified on the command line.

### AzureResourceSchema multi-api

``` yaml $(azureresourceschema) && $(multiapi)
batch:
  - tag: package-netapp-2020-02-01
  - tag: package-netapp-2019-11-01
  - tag: package-netapp-2019-10-01
  - tag: package-netapp-2019-08-01
  - tag: package-netapp-2019-07-01
  - tag: package-netapp-2019-06-01
  - tag: package-netapp-2019-05-01
  - tag: package-2017-08-15
```

### Tag: package-netapp-2020-02-01 and azureresourceschema

These settings apply only when `--tag=package-netapp-2020-02-01 --azureresourceschema` is specified on the command line.
Please also specify `--azureresourceschema-folder=<path to the root directory of your azure-resource-manager-schemas clone>`.

``` yaml $(tag) == 'package-netapp-2020-02-01' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas
```

### Tag: package-netapp-2019-11-01 and azureresourceschema

These settings apply only when `--tag=package-netapp-2019-11-01 --azureresourceschema` is specified on the command line.
Please also specify `--azureresourceschema-folder=<path to the root directory of your azure-resource-manager-schemas clone>`.

``` yaml $(tag) == 'package-netapp-2019-11-01' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas
```

### Tag: package-netapp-2019-10-01 and azureresourceschema

These settings apply only when `--tag=package-netapp-2019-10-01 --azureresourceschema` is specified on the command line.
Please also specify `--azureresourceschema-folder=<path to the root directory of your azure-resource-manager-schemas clone>`.

``` yaml $(tag) == 'package-netapp-2019-10-01' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas
```

### Tag: package-netapp-2019-08-01 and azureresourceschema

These settings apply only when `--tag=package-netapp-2019-08-01 --azureresourceschema` is specified on the command line.
Please also specify `--azureresourceschema-folder=<path to the root directory of your azure-resource-manager-schemas clone>`.

``` yaml $(tag) == 'package-netapp-2019-08-01' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas
```

### Tag: package-netapp-2019-07-01 and azureresourceschema

These settings apply only when `--tag=package-netapp-2019-07-01 --azureresourceschema` is specified on the command line.
Please also specify `--azureresourceschema-folder=<path to the root directory of your azure-resource-manager-schemas clone>`.

``` yaml $(tag) == 'package-netapp-2019-07-01' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas
```

### Tag: package-netapp-2019-06-01 and azureresourceschema

These settings apply only when `--tag=package-netapp-2019-06-01 --azureresourceschema` is specified on the command line.
Please also specify `--azureresourceschema-folder=<path to the root directory of your azure-resource-manager-schemas clone>`.

``` yaml $(tag) == 'package-netapp-2019-06-01' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas
```

### Tag: package-netapp-2019-05-01 and azureresourceschema

These settings apply only when `--tag=package-netapp-2019-05-01 --azureresourceschema` is specified on the command line.
Please also specify `--azureresourceschema-folder=<path to the root directory of your azure-resource-manager-schemas clone>`.

``` yaml $(tag) == 'package-netapp-2019-05-01' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas
```

### Tag: package-2017-08-15 and azureresourceschema

These settings apply only when `--tag=package-2017-08-15 --azureresourceschema` is specified on the command line.
Please also specify `--azureresourceschema-folder=<path to the root directory of your azure-resource-manager-schemas clone>`.

``` yaml $(tag) == 'package-2017-08-15' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas
```


## AzureResourceSchema

These settings apply only when `--azureresourceschema` is specified on the command line.

### AzureResourceSchema multi-api

``` yaml $(azureresourceschema) && $(multiapi)
batch:
  - tag: package-webservices-2017-01
  - tag: package-commitmentPlans-2016-05-preview
  - tag: package-workspaces-2016-04
  - tag: package-workspaces-2019-10
  - tag: package-webservices-2016-05-preview
```

### Tag: package-webservices-2017-01 and azureresourceschema

These settings apply only when `--tag=package-webservices-2017-01 --azureresourceschema` is specified on the command line.
Please also specify `--azureresourceschema-folder=<path to the root directory of your azure-resource-manager-schemas clone>`.

``` yaml $(tag) == 'package-webservices-2017-01' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas
```

### Tag: package-commitmentPlans-2016-05-preview and azureresourceschema

These settings apply only when `--tag=package-commitmentPlans-2016-05-preview --azureresourceschema` is specified on the command line.
Please also specify `--azureresourceschema-folder=<path to the root directory of your azure-resource-manager-schemas clone>`.

``` yaml $(tag) == 'package-commitmentPlans-2016-05-preview' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas
```

### Tag: package-workspaces-2016-04 and azureresourceschema

These settings apply only when `--tag=package-workspaces-2016-04 --azureresourceschema` is specified on the command line.
Please also specify `--azureresourceschema-folder=<path to the root directory of your azure-resource-manager-schemas clone>`.

``` yaml $(tag) == 'package-workspaces-2016-04' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas
```

### Tag: package-workspaces-2019-10 and azureresourceschema

These settings apply only when `--tag=package-workspaces-2019-10 --azureresourceschema` is specified on the command line.
Please also specify `--azureresourceschema-folder=<path to the root directory of your azure-resource-manager-schemas clone>`.

``` yaml $(tag) == 'package-workspaces-2019-10' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas
```

### Tag: package-webservices-2016-05-preview and azureresourceschema

These settings apply only when `--tag=package-webservices-2016-05-preview --azureresourceschema` is specified on the command line.
Please also specify `--azureresourceschema-folder=<path to the root directory of your azure-resource-manager-schemas clone>`.

``` yaml $(tag) == 'package-webservices-2016-05-preview' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas
```


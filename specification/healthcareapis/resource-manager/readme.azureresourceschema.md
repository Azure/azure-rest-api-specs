## AzureResourceSchema

These settings apply only when `--azureresourceschema` is specified on the command line.

### AzureResourceSchema multi-api

``` yaml $(azureresourceschema) && $(multiapi)
batch:
  - tag: schema-healthcareapis-2020-03-15
  - tag: schema-healthcareapis-2019-09-16
  - tag: schema-healthcareapis-2018-08-20-preview

```

Please also specify `--azureresourceschema-folder=<path to the root directory of your azure-resource-manager-schemas clone>`.

### Tag: schema-healthcareapis-2020-03-15 and azureresourceschema

``` yaml $(tag) == 'schema-healthcareapis-2020-03-15' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.HealthcareApis/stable/2020-03-15/healthcare-apis.json

```

### Tag: schema-healthcareapis-2019-09-16 and azureresourceschema

``` yaml $(tag) == 'schema-healthcareapis-2019-09-16' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.HealthcareApis/stable/2019-09-16/healthcare-apis.json

```

### Tag: schema-healthcareapis-2018-08-20-preview and azureresourceschema

``` yaml $(tag) == 'schema-healthcareapis-2018-08-20-preview' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.HealthcareApis/preview/2018-08-20-preview/healthcare-apis.json

```

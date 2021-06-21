## AzureResourceSchema

These settings apply only when `--azureresourceschema` is specified on the command line.

### AzureResourceSchema multi-api

``` yaml $(azureresourceschema) && $(multiapi)
batch:
  - tag: schema-managementpartner-2018-02-01

```

Please also specify `--azureresourceschema-folder=<path to the root directory of your azure-resource-manager-schemas clone>`.

### Tag: schema-managementpartner-2018-02-01 and azureresourceschema

``` yaml $(tag) == 'schema-managementpartner-2018-02-01' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.ManagementPartner/preview/2018-02-01/ManagementPartner.json

```

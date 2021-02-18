## AzureResourceSchema

These settings apply only when `--azureresourceschema` is specified on the command line.

### AzureResourceSchema multi-api

``` yaml $(azureresourceschema) && $(multiapi)
batch:
  - tag: schema-powerbidedicated-2017-10-01

```

Please also specify `--azureresourceschema-folder=<path to the root directory of your azure-resource-manager-schemas clone>`.

### Tag: schema-powerbidedicated-2017-10-01 and azureresourceschema

``` yaml $(tag) == 'schema-powerbidedicated-2017-10-01' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.PowerBIdedicated/stable/2017-10-01/powerbidedicated.json

```

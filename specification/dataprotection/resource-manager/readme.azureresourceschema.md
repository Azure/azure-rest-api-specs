## AzureResourceSchema

These settings apply only when `--azureresourceschema` is specified on the command line.

### AzureResourceSchema multi-api

``` yaml $(azureresourceschema) && $(multiapi)
batch:
  - tag: schema-dataprotection-2020-01-01-alpha
  
```

Please also specify `--azureresourceschema-folder=<path to the root directory of your azure-resource-manager-schemas clone>`.

### Tag: schema-dataprotection-2020-01-01-alpha and azureresourceschema

``` yaml $(tag) == 'schema-dataprotection-2020-01-01-alpha' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.DataProtection/preview/2020-01-01-alpha/dataprotection.json
```

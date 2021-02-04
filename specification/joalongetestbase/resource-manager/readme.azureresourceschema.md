## AzureResourceSchema

These settings apply only when `--azureresourceschema` is specified on the command line.

### AzureResourceSchema multi-api

``` yaml $(azureresourceschema) && $(multiapi)
batch:
  - tag: schema-joalongetestbase-2020-02-04
  
```

Please also specify `--azureresourceschema-folder=<path to the root directory of your azure-resource-manager-schemas clone>`.

### Tag: schema-joalongetestbase-2020-02-04 and azureresourceschema

``` yaml $(tag) == 'schema-joalongetestbase-2020-02-04' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.Joalonge/preview/2020-02-04/joalongetestbase.json
```

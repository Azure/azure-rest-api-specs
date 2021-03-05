## AzureResourceSchema

These settings apply only when `--azureresourceschema` is specified on the command line.

### AzureResourceSchema multi-api

``` yaml $(azureresourceschema) && $(multiapi)
batch:
  - tag: schema-dfp-2021-02-01-privatepreview
  
```

Please also specify `--azureresourceschema-folder=<path to the root directory of your azure-resource-manager-schemas clone>`.

### Tag: schema-dfp-2021-02-01-privatepreview and azureresourceschema

``` yaml $(tag) == 'schema-dfp-2021-02-01-privatepreview' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.DFP/preview/2021-02-01-privatepreview/dfp.json
```

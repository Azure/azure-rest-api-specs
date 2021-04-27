## AzureResourceSchema

These settings apply only when `--azureresourceschema` is specified on the command line.

### AzureResourceSchema multi-api

``` yaml $(azureresourceschema) && $(multiapi)
batch:
  - tag: schema-tianennotebooks-2021-04-27.1408
  
```

Please also specify `--azureresourceschema-folder=<path to the root directory of your azure-resource-manager-schemas clone>`.

### Tag: schema-tianennotebooks-2021-04-27.1408 and azureresourceschema

``` yaml $(tag) == 'schema-tianennotebooks-2021-04-27.1408' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.TianenNotebooks/preview/2021-04-27.1408/tianennotebooks.json
```

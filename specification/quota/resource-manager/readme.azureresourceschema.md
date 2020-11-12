## AzureResourceSchema

These settings apply only when `--azureresourceschema` is specified on the command line.

### AzureResourceSchema multi-api

``` yaml $(azureresourceschema) && $(multiapi)
batch:
  - tag: schema-capacity-2020-11-11
  - tag: schema-capacity-2019-07-19
  
```

Please also specify `--azureresourceschema-folder=<path to the root directory of your azure-resource-manager-schemas clone>`.

### Tag: schema-capacity-2020-11-11 and azureresourceschema

``` yaml $(tag) == 'schema-capacity-2020-11-11' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.Capacity/stable/2020-11-11/quota.json

```

### Tag: schema-capacity-2019-07-19 and azureresourceschema

``` yaml $(tag) == 'schema-capacity-2019-07-19' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.Capacity/preview/2019-07-19/quota.json
```

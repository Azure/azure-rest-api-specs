## AzureResourceSchema

These settings apply only when `--azureresourceschema` is specified on the command line.

### AzureResourceSchema multi-api

``` yaml $(azureresourceschema) && $(multiapi)
batch:
  - tag: schema-capacity-2021-03-15-preview
 
```

Please also specify `--azureresourceschema-folder=<path to the root directory of your azure-resource-manager-schemas clone>`.

### Tag: schema-capacity-2020-11-15-preview and azureresourceschema

``` yaml $(tag) == 'schema-capacity-2021-03-15-preview' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.Capacity/preview/2021-03-15/quota.json

```

### Tag: schema-capacity-2020-10-25 and azureresourceschema

``` yaml $(tag) == 'schema-capacity-2020-10-25' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.Capacity/stable/2020-10-25/quota.json

```

# all the input files in this apiVersion
input-file:
  - Microsoft.Capacity/preview/2021-03-15/quota.json

```
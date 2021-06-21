## AzureResourceSchema

These settings apply only when `--azureresourceschema` is specified on the command line.

### AzureResourceSchema multi-api

``` yaml $(azureresourceschema) && $(multiapi)
batch:
  - tag: schema-quota-2021-03-15 
```

Please also specify `--azureresourceschema-folder=<path to the root directory of your azure-resource-manager-schemas clone>`.

### Tag: schema-quota-2021-03-15 and azureresourceschema

``` yaml $(tag) == 'schema-quota-2021-03-15' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.Quota/stable/2021-03-15/quota.json

```

# all the input files in this apiVersion
input-file:
  - Microsoft.Quota/stable/2021-03-15/quota.json
```

### Tag: schema-quota-2021-03-15-preview and azureresourceschema

``` yaml $(tag) == 'schema-quota-2021-03-15-preview' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.Quota/review/2021-03-15-preview/quota.json

```

# all the input files in this apiVersion
input-file:
  - Microsoft.Quota/preview/2021-03-15-preview/quota.json
```
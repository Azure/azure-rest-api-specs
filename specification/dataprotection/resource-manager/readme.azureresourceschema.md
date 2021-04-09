## AzureResourceSchema

These settings apply only when `--azureresourceschema` is specified on the command line.

### AzureResourceSchema multi-api

``` yaml $(azureresourceschema) && $(multiapi)
batch:
  - tag: schema-dataprotection-2021-02-01-preview
  - tag: schema-dataprotection-2021-01-01

```

Please also specify `--azureresourceschema-folder=<path to the root directory of your azure-resource-manager-schemas clone>`.

### Tag: schema-dataprotection-2021-02-01-preview and azureresourceschema

``` yaml $(tag) == 'schema-dataprotection-2021-02-01-preview' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.DataProtection/preview/2021-02-01-preview/dataprotection.json

```

### Tag: schema-dataprotection-2021-01-01 and azureresourceschema

``` yaml $(tag) == 'schema-dataprotection-2021-01-01' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.DataProtection/stable/2021-01-01/dataprotection.json

```

## AzureResourceSchema

These settings apply only when `--azureresourceschema` is specified on the command line.

### AzureResourceSchema multi-api

``` yaml $(azureresourceschema) && $(multiapi)
batch:
  - tag: schema-support-2020-04-01
  - tag: schema-support-2019-05-01-preview

```

Please also specify `--azureresourceschema-folder=<path to the root directory of your azure-resource-manager-schemas clone>`.

### Tag: schema-support-2020-04-01 and azureresourceschema

``` yaml $(tag) == 'schema-support-2020-04-01' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.Support/stable/2020-04-01/support.json

```

### Tag: schema-support-2019-05-01-preview and azureresourceschema

``` yaml $(tag) == 'schema-support-2019-05-01-preview' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.Support/preview/2019-05-01-preview/support.json

```

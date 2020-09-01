## AzureResourceSchema

These settings apply only when `--azureresourceschema` is specified on the command line.

### AzureResourceSchema multi-api

``` yaml $(azureresourceschema) && $(multiapi)
batch:
  - tag: schema-batchai-2018-05-01
  - tag: schema-batchai-2018-03-01
  - tag: schema-batchai-2017-09-01-preview

```

Please also specify `--azureresourceschema-folder=<path to the root directory of your azure-resource-manager-schemas clone>`.

### Tag: schema-batchai-2018-05-01 and azureresourceschema

``` yaml $(tag) == 'schema-batchai-2018-05-01' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.BatchAI/stable/2018-05-01/BatchAI.json

```

### Tag: schema-batchai-2018-03-01 and azureresourceschema

``` yaml $(tag) == 'schema-batchai-2018-03-01' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.BatchAI/stable/2018-03-01/BatchAI.json

```

### Tag: schema-batchai-2017-09-01-preview and azureresourceschema

``` yaml $(tag) == 'schema-batchai-2017-09-01-preview' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.BatchAI/preview/2017-09-01-preview/BatchAI.json

```

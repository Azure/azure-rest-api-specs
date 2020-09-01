## AzureResourceSchema

These settings apply only when `--azureresourceschema` is specified on the command line.

### AzureResourceSchema multi-api

``` yaml $(azureresourceschema) && $(multiapi)
batch:
  - tag: schema-enterpriseknowledgegraph-2018-12-03

```

Please also specify `--azureresourceschema-folder=<path to the root directory of your azure-resource-manager-schemas clone>`.

### Tag: schema-enterpriseknowledgegraph-2018-12-03 and azureresourceschema

``` yaml $(tag) == 'schema-enterpriseknowledgegraph-2018-12-03' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.EnterpriseKnowledgeGraph/preview/2018-12-03/EnterpriseKnowledgeGraphSwagger.json

```

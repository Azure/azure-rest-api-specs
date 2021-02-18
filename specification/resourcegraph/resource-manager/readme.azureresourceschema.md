## AzureResourceSchema

These settings apply only when `--azureresourceschema` is specified on the command line.

### AzureResourceSchema multi-api

``` yaml $(azureresourceschema) && $(multiapi)
batch:
  - tag: schema-resourcegraph-2020-04-01-preview
  - tag: schema-resourcegraph-2019-04-01
  - tag: schema-resourcegraph-2018-09-01-preview

```

Please also specify `--azureresourceschema-folder=<path to the root directory of your azure-resource-manager-schemas clone>`.

### Tag: schema-resourcegraph-2020-04-01-preview and azureresourceschema

``` yaml $(tag) == 'schema-resourcegraph-2020-04-01-preview' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.ResourceGraph/preview/2020-04-01-preview/resourcegraph.json

```

### Tag: schema-resourcegraph-2019-04-01 and azureresourceschema

``` yaml $(tag) == 'schema-resourcegraph-2019-04-01' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.ResourceGraph/stable/2019-04-01/resourcegraph.json

```

### Tag: schema-resourcegraph-2018-09-01-preview and azureresourceschema

``` yaml $(tag) == 'schema-resourcegraph-2018-09-01-preview' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.ResourceGraph/preview/2018-09-01-preview/resourcegraph.json
  - Microsoft.ResourceGraph/preview/2018-09-01-preview/graphquery.json

```

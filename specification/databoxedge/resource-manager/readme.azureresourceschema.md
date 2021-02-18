## AzureResourceSchema

These settings apply only when `--azureresourceschema` is specified on the command line.

### AzureResourceSchema multi-api

``` yaml $(azureresourceschema) && $(multiapi)
batch:
  - tag: schema-databoxedge-2020-05-01-preview
  - tag: schema-databoxedge-2019-08-01
  - tag: schema-databoxedge-2019-07-01
  - tag: schema-databoxedge-2019-03-01

```

Please also specify `--azureresourceschema-folder=<path to the root directory of your azure-resource-manager-schemas clone>`.

### Tag: schema-databoxedge-2020-05-01-preview and azureresourceschema

``` yaml $(tag) == 'schema-databoxedge-2020-05-01-preview' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.DataBoxEdge/preview/2020-05-01-preview/databoxedge.json

```

### Tag: schema-databoxedge-2019-08-01 and azureresourceschema

``` yaml $(tag) == 'schema-databoxedge-2019-08-01' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.DataBoxEdge/stable/2019-08-01/databoxedge.json

```

### Tag: schema-databoxedge-2019-07-01 and azureresourceschema

``` yaml $(tag) == 'schema-databoxedge-2019-07-01' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.DataBoxEdge/stable/2019-07-01/databoxedge.json

```

### Tag: schema-databoxedge-2019-03-01 and azureresourceschema

``` yaml $(tag) == 'schema-databoxedge-2019-03-01' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.DataBoxEdge/stable/2019-03-01/databoxedge.json

```

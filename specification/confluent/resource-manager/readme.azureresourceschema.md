## AzureResourceSchema

These settings apply only when `--azureresourceschema` is specified on the command line.

### AzureResourceSchema multi-api

``` yaml $(azureresourceschema) && $(multiapi)
batch:
  - tag: schema-confluent-2020-03-01-preview
  - tag: schema-confluent-2020-03-01

```

Please also specify `--azureresourceschema-folder=<path to the root directory of your azure-resource-manager-schemas clone>`.

### Tag: schema-confluent-2020-03-01-preview and azureresourceschema

``` yaml $(tag) == 'schema-confluent-2020-03-01-preview' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.Confluent/preview/2020-03-01-preview/confluent.json

```

### Tag: schema-confluent-2020-03-01 and azureresourceschema

``` yaml $(tag) == 'schema-confluent-2020-03-01' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.Confluent/stable/2020-03-01/confluent.json

```

## AzureResourceSchema

These settings apply only when `--azureresourceschema` is specified on the command line.

### AzureResourceSchema multi-api

``` yaml $(azureresourceschema) && $(multiapi)
batch:
  - tag: schema-hanaonazure-2020-02-07-preview
  - tag: schema-hanaonazure-2017-11-03-preview

```

Please also specify `--azureresourceschema-folder=<path to the root directory of your azure-resource-manager-schemas clone>`.

### Tag: schema-hanaonazure-2020-02-07-preview and azureresourceschema

``` yaml $(tag) == 'schema-hanaonazure-2020-02-07-preview' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.HanaOnAzure/preview/2020-02-07-preview/hanaonazure.json

```

### Tag: schema-hanaonazure-2017-11-03-preview and azureresourceschema

``` yaml $(tag) == 'schema-hanaonazure-2017-11-03-preview' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.HanaOnAzure/preview/2017-11-03-preview/hanaonazure.json

```

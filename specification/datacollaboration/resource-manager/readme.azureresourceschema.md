## AzureResourceSchema

These settings apply only when `--azureresourceschema` is specified on the command line.

### AzureResourceSchema multi-api

``` yaml $(azureresourceschema) && $(multiapi)
batch:
  - tag: package-2020-05-04-preview
  - tag: package-2022-05-04-preview

```

Please also specify `--azureresourceschema-folder=<path to the root directory of your azure-resource-manager-schemas clone>`.

### Tag: schema-datacollaboration-package-2020-05-04-preview and azureresourceschema

``` yaml $(tag) == 'schema-datacollaboration-2020-05-04-preview' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.DataCollaboration/preview/2020-05-04-preview/DataCollaboration.json

```

### Tag: schema-datacollaboration-package-2022-05-04-preview and azureresourceschema

``` yaml $(tag) == 'schema-datacollaboration-2022-05-04-preview' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.DataCollaboration/preview/2022-05-04-preview/DataCollaboration.json

```

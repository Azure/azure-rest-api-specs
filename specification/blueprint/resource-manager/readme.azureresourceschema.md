## AzureResourceSchema

These settings apply only when `--azureresourceschema` is specified on the command line.

### AzureResourceSchema multi-api

``` yaml $(azureresourceschema) && $(multiapi)
batch:
  - tag: schema-blueprint-2018-11-01-preview
  - tag: schema-blueprint-2017-11-11-preview

```

Please also specify `--azureresourceschema-folder=<path to the root directory of your azure-resource-manager-schemas clone>`.

### Tag: schema-blueprint-2018-11-01-preview and azureresourceschema

``` yaml $(tag) == 'schema-blueprint-2018-11-01-preview' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.Blueprint/preview/2018-11-01-preview/blueprintDefinition.json
  - Microsoft.Blueprint/preview/2018-11-01-preview/blueprintAssignment.json
  - Microsoft.Blueprint/preview/2018-11-01-preview/assignmentOperation.json

```

### Tag: schema-blueprint-2017-11-11-preview and azureresourceschema

``` yaml $(tag) == 'schema-blueprint-2017-11-11-preview' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.Blueprint/preview/2017-11-11-preview/blueprintDefinition.json
  - Microsoft.Blueprint/preview/2017-11-11-preview/blueprintAssignment.json

```

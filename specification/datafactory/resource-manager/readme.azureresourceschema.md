## AzureResourceSchema

These settings apply only when `--azureresourceschema` is specified on the command line.

### AzureResourceSchema multi-api

``` yaml $(azureresourceschema) && $(multiapi)
batch:
  - tag: schema-datafactory-2018-06-01
  - tag: schema-datafactory-2017-09-01-preview

```

Please also specify `--azureresourceschema-folder=<path to the root directory of your azure-resource-manager-schemas clone>`.

### Tag: schema-datafactory-2018-06-01 and azureresourceschema

``` yaml $(tag) == 'schema-datafactory-2018-06-01' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.DataFactory/stable/2018-06-01/datafactory.json
  - Microsoft.DataFactory/stable/2018-06-01/entityTypes/DataFlow.json
  - Microsoft.DataFactory/stable/2018-06-01/entityTypes/Dataset.json
  - Microsoft.DataFactory/stable/2018-06-01/entityTypes/IntegrationRuntime.json
  - Microsoft.DataFactory/stable/2018-06-01/entityTypes/LinkedService.json
  - Microsoft.DataFactory/stable/2018-06-01/entityTypes/ManagedPrivateEndpoint.json
  - Microsoft.DataFactory/stable/2018-06-01/entityTypes/Pipeline.json
  - Microsoft.DataFactory/stable/2018-06-01/entityTypes/Trigger.json

```

### Tag: schema-datafactory-2017-09-01-preview and azureresourceschema

``` yaml $(tag) == 'schema-datafactory-2017-09-01-preview' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.DataFactory/preview/2017-09-01-preview/datafactory.json

```

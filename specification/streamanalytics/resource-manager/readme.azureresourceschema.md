## AzureResourceSchema

These settings apply only when `--azureresourceschema` is specified on the command line.

### AzureResourceSchema multi-api

``` yaml $(azureresourceschema) && $(multiapi)
batch:
  - tag: schema-streamanalytics-2020-03-01-preview
  - tag: schema-streamanalytics-2017-04-01-preview
  - tag: schema-streamanalytics-2016-03-01

```

Please also specify `--azureresourceschema-folder=<path to the root directory of your azure-resource-manager-schemas clone>`.

### Tag: schema-streamanalytics-2020-03-01-preview and azureresourceschema

``` yaml $(tag) == 'schema-streamanalytics-2020-03-01-preview' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.StreamAnalytics/preview/2020-03-01-preview/clusters.json
  - Microsoft.StreamAnalytics/preview/2020-03-01-preview/privateEndpoints.json

```

### Tag: schema-streamanalytics-2017-04-01-preview and azureresourceschema

``` yaml $(tag) == 'schema-streamanalytics-2017-04-01-preview' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.StreamAnalytics/preview/2017-04-01-preview/functions.json
  - Microsoft.StreamAnalytics/preview/2017-04-01-preview/inputs.json
  - Microsoft.StreamAnalytics/preview/2017-04-01-preview/outputs.json
  - Microsoft.StreamAnalytics/preview/2017-04-01-preview/streamingjobs.json
  - Microsoft.StreamAnalytics/preview/2017-04-01-preview/subscriptions.json
  - Microsoft.StreamAnalytics/preview/2017-04-01-preview/transformations.json
  - Microsoft.StreamAnalytics/preview/2017-04-01-preview/operations.json

```

### Tag: schema-streamanalytics-2016-03-01 and azureresourceschema

``` yaml $(tag) == 'schema-streamanalytics-2016-03-01' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.StreamAnalytics/stable/2016-03-01/streamingjobs.json
  - Microsoft.StreamAnalytics/stable/2016-03-01/inputs.json
  - Microsoft.StreamAnalytics/stable/2016-03-01/outputs.json
  - Microsoft.StreamAnalytics/stable/2016-03-01/transformations.json
  - Microsoft.StreamAnalytics/stable/2016-03-01/functions.json
  - Microsoft.StreamAnalytics/stable/2016-03-01/subscriptions.json

```

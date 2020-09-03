## AzureResourceSchema

These settings apply only when `--azureresourceschema` is specified on the command line.

### AzureResourceSchema multi-api

``` yaml $(azureresourceschema) && $(multiapi)
batch:
  - tag: schema-cognitiveservices-2017-04-18
  - tag: schema-cognitiveservices-2016-02-01-preview

```

Please also specify `--azureresourceschema-folder=<path to the root directory of your azure-resource-manager-schemas clone>`.

### Tag: schema-cognitiveservices-2017-04-18 and azureresourceschema

``` yaml $(tag) == 'schema-cognitiveservices-2017-04-18' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.CognitiveServices/stable/2017-04-18/cognitiveservices.json

```

### Tag: schema-cognitiveservices-2016-02-01-preview and azureresourceschema

``` yaml $(tag) == 'schema-cognitiveservices-2016-02-01-preview' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.CognitiveServices/preview/2016-02-01-preview/cognitiveservices.json

```

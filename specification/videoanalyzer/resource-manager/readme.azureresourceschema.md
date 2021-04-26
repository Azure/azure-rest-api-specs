## AzureResourceSchema

These settings apply only when `--azureresourceschema` is specified on the command line.

### AzureResourceSchema multi-api

``` yaml $(azureresourceschema) && $(multiapi)
batch:
  - tag: schema-videoanalyzer-2021-05-01-preview
  
```

Please also specify `--azureresourceschema-folder=<path to the root directory of your azure-resource-manager-schemas clone>`.

### Tag: schema-videoanalyzer-2021-05-01-preview and azureresourceschema

``` yaml $(tag) == 'schema-videoanalyzer-2021-05-01-preview' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.Media/preview/2021-05-01-preview/VideoAnalyzers.json
  - Microsoft.Media/preview/2021-05-01-preview/EdgeModules.json
  - Microsoft.Media/preview/2021-05-01-preview/Videos.json
```

## AzureResourceSchema

These settings apply only when `--azureresourceschema` is specified on the command line.

### AzureResourceSchema multi-api

``` yaml $(azureresourceschema) && $(multiapi)
batch:
  - tag: schema-powerbi-2016-01-29

```

Please also specify `--azureresourceschema-folder=<path to the root directory of your azure-resource-manager-schemas clone>`.

### Tag: schema-powerbi-2016-01-29 and azureresourceschema

``` yaml $(tag) == 'schema-powerbi-2016-01-29' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.PowerBI/stable/2016-01-29/powerbiembedded.json

```

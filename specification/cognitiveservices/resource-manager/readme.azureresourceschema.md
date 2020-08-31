## AzureResourceSchema

These settings apply only when `--azureresourceschema` is specified on the command line.

### AzureResourceSchema multi-api

``` yaml $(azureresourceschema) && $(multiapi)
# include the azure profile definitions from the standard location
require: ../../../profiles/readme.md

output-folder: $(azureresourceschema-folder)/schemas

# all the input files across all versions
input-file:
  - Microsoft.CognitiveServices/stable/2017-04-18/cognitiveservices.json
  - Microsoft.CognitiveServices/preview/2016-02-01-preview/cognitiveservices.json

```
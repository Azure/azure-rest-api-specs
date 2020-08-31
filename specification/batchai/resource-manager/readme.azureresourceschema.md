## AzureResourceSchema

These settings apply only when `--azureresourceschema` is specified on the command line.

### AzureResourceSchema multi-api

``` yaml $(azureresourceschema) && $(multiapi)
# include the azure profile definitions from the standard location
require: ../../../profiles/readme.md

output-folder: $(azureresourceschema-folder)/schemas

# all the input files across all versions
input-file:
  - Microsoft.BatchAI/preview/2017-09-01-preview/BatchAI.json
  - Microsoft.BatchAI/stable/2018-03-01/BatchAI.json
  - Microsoft.BatchAI/stable/2018-05-01/BatchAI.json

```
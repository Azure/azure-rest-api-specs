## AzureResourceSchema

These settings apply only when `--azureresourceschema` is specified on the command line.

### AzureResourceSchema multi-api

``` yaml $(azureresourceschema) && $(multiapi)
# include the azure profile definitions from the standard location
require: ../../../profiles/readme.md

output-folder: $(azureresourceschema-folder)/schemas

# all the input files across all versions
input-file:
  - Microsoft.Blueprint/preview/2017-11-11-preview/blueprintDefinition.json
  - Microsoft.Blueprint/preview/2017-11-11-preview/blueprintAssignment.json
  - Microsoft.Blueprint/preview/2018-11-01-preview/blueprintDefinition.json
  - Microsoft.Blueprint/preview/2018-11-01-preview/blueprintAssignment.json
  - Microsoft.Blueprint/preview/2018-11-01-preview/assignmentOperation.json

```
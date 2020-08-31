## AzureResourceSchema

These settings apply only when `--azureresourceschema` is specified on the command line.

### AzureResourceSchema multi-api

``` yaml $(azureresourceschema) && $(multiapi)
# include the azure profile definitions from the standard location
require: ../../../profiles/readme.md

output-folder: $(azureresourceschema-folder)/schemas

# all the input files across all versions
input-file:
  - Microsoft.AnalysisServices/stable/2017-08-01/analysisservices.json
  - Microsoft.AnalysisServices/preview/2017-08-01-beta/analysisservices.json
  - Microsoft.AnalysisServices/stable/2017-07-14/analysisservices.json
  - Microsoft.AnalysisServices/stable/2016-05-16/analysisservices.json

```
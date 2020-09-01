## AzureResourceSchema

These settings apply only when `--azureresourceschema` is specified on the command line.

### AzureResourceSchema multi-api

``` yaml $(azureresourceschema) && $(multiapi)
# include the azure profile definitions from the standard location
require: ../../../profiles/readme.md

output-folder: $(azureresourceschema-folder)/schemas

# all the input files across all versions
input-file:
  - Microsoft.StreamAnalytics/stable/2016-03-01/streamingjobs.json
  - Microsoft.StreamAnalytics/stable/2016-03-01/inputs.json
  - Microsoft.StreamAnalytics/stable/2016-03-01/outputs.json
  - Microsoft.StreamAnalytics/stable/2016-03-01/transformations.json
  - Microsoft.StreamAnalytics/stable/2016-03-01/functions.json
  - Microsoft.StreamAnalytics/stable/2016-03-01/subscriptions.json

```
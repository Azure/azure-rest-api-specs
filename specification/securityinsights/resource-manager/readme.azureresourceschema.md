## AzureResourceSchema

These settings apply only when `--azureresourceschema` is specified on the command line.

### AzureResourceSchema multi-api

``` yaml $(azureresourceschema) && $(multiapi)
# include the azure profile definitions from the standard location
require: ../../../profiles/readme.md

output-folder: $(azureresourceschema-folder)/schemas

# all the input files across all versions
input-file:
  - Microsoft.SecurityInsights/stable/2020-01-01/SecurityInsights.json
  - Microsoft.SecurityInsights/preview/2019-01-01-preview/SecurityInsights.json

```
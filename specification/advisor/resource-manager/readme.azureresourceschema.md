## AzureResourceSchema

These settings apply only when `--azureresourceschema` is specified on the command line.

### AzureResourceSchema multi-api

``` yaml $(azureresourceschema) && $(multiapi)
# include the azure profile definitions from the standard location
require: ../../../profiles/readme.md

output-folder: $(azureresourceschema-folder)/schemas

# all the input files across all versions
input-file:
  - Microsoft.Advisor/preview/2020-07-01-preview/advisor.json
  - Microsoft.Advisor/stable/2020-01-01/advisor.json
  - Microsoft.Advisor/stable/2017-04-19/advisor.json
  - Microsoft.Advisor/stable/2017-03-31/advisor.json
  - Microsoft.Advisor/preview/2016-07-12-preview/advisor.json

```
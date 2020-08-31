## AzureResourceSchema

These settings apply only when `--azureresourceschema` is specified on the command line.

### AzureResourceSchema multi-api

``` yaml $(azureresourceschema) && $(multiapi)
# include the azure profile definitions from the standard location
require: ../../../profiles/readme.md

output-folder: $(azureresourceschema-folder)/schemas

# all the input files across all versions
input-file:
  - Microsoft.Maintenance/preview/2020-07-01-preview/Maintenance.json
  - Microsoft.Maintenance/stable/2020-04-01/Maintenance.json
  - Microsoft.Maintenance/preview/2018-06-01-preview/Maintenance.json

```
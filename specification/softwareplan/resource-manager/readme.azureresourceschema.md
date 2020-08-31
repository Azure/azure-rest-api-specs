## AzureResourceSchema

These settings apply only when `--azureresourceschema` is specified on the command line.

### AzureResourceSchema multi-api

``` yaml $(azureresourceschema) && $(multiapi)
# include the azure profile definitions from the standard location
require: ../../../profiles/readme.md

output-folder: $(azureresourceschema-folder)/schemas

# all the input files across all versions
input-file:
  - Microsoft.SoftwarePlan/preview/2019-06-01-preview/softwareplan.json
  - Microsoft.SoftwarePlan/stable/2019-12-01/softwareplan.json

```
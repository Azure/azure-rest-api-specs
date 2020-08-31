## AzureResourceSchema

These settings apply only when `--azureresourceschema` is specified on the command line.

### AzureResourceSchema multi-api

``` yaml $(azureresourceschema) && $(multiapi)
# include the azure profile definitions from the standard location
require: ../../../profiles/readme.md

output-folder: $(azureresourceschema-folder)/schemas

# all the input files across all versions
input-file:
  - Microsoft.CostManagement/stable/2020-06-01/costmanagement.json
  - Microsoft.CostManagement/preview/2020-03-01-preview/costallocation.json
  - Microsoft.CostManagement/stable/2019-11-01/costmanagement.json
  - Microsoft.CostManagement/stable/2019-10-01/costmanagement.json
  - Microsoft.CostManagement/stable/2019-09-01/costmanagement.json
  - Microsoft.CostManagement/preview/2019-04-01-preview/costmanagement.json
  - Microsoft.CostManagement/stable/2019-01-01/costmanagement.json
  - Microsoft.CostManagement/preview/2019-03-01-preview/costmanagement.json
  - Microsoft.CostManagement/stable/2018-05-31/costmanagement.json
  - Microsoft.CostManagement/preview/2018-08-01-preview/costmanagement.json
  - Microsoft.CostManagement/preview/2018-12-01-preview/costmanagement.json

```
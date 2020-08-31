## AzureResourceSchema

These settings apply only when `--azureresourceschema` is specified on the command line.

### AzureResourceSchema multi-api

``` yaml $(azureresourceschema) && $(multiapi)
# include the azure profile definitions from the standard location
require: ../../../profiles/readme.md

output-folder: $(azureresourceschema-folder)/schemas

# all the input files across all versions
input-file:
  - Microsoft.MachineLearning/stable/2017-01-01/webservices.json
  - Microsoft.MachineLearning/preview/2016-05-01-preview/commitmentPlans.json
  - Microsoft.MachineLearning/stable/2016-04-01/workspaces.json
  - Microsoft.MachineLearning/stable/2019-10-01/workspaces.json
  - Microsoft.MachineLearning/preview/2016-05-01-preview/webservices.json

```
## AzureResourceSchema

These settings apply only when `--azureresourceschema` is specified on the command line.

### AzureResourceSchema multi-api

``` yaml $(azureresourceschema) && $(multiapi)
# include the azure profile definitions from the standard location
require: ../../../profiles/readme.md

output-folder: $(azureresourceschema-folder)/schemas

# all the input files across all versions
input-file:
  - Microsoft.Batch/stable/2020-05-01/BatchManagement.json
  - Microsoft.Batch/stable/2020-03-01/BatchManagement.json
  - Microsoft.Batch/stable/2019-08-01/BatchManagement.json
  - Microsoft.Batch/stable/2019-04-01/BatchManagement.json
  - Microsoft.Batch/stable/2018-12-01/BatchManagement.json
  - Microsoft.Batch/stable/2017-09-01/BatchManagement.json
  - Microsoft.Batch/stable/2017-05-01/BatchManagement.json
  - Microsoft.Batch/stable/2017-01-01/BatchManagement.json
  - Microsoft.Batch/stable/2015-12-01/BatchManagement.json

```
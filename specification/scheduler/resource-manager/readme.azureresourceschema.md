## AzureResourceSchema

These settings apply only when `--azureresourceschema` is specified on the command line.

### AzureResourceSchema multi-api

``` yaml $(azureresourceschema) && $(multiapi)
# include the azure profile definitions from the standard location
require: ../../../profiles/readme.md

output-folder: $(azureresourceschema-folder)/schemas

# all the input files across all versions
input-file:
  - Microsoft.Scheduler/stable/2016-03-01/scheduler.json
  - Microsoft.Scheduler/stable/2016-01-01/scheduler.json
  - Microsoft.Scheduler/preview/2014-08-01-preview/scheduler.json

```
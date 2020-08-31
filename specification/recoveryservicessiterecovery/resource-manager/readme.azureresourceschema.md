## AzureResourceSchema

These settings apply only when `--azureresourceschema` is specified on the command line.

### AzureResourceSchema multi-api

``` yaml $(azureresourceschema) && $(multiapi)
# include the azure profile definitions from the standard location
require: ../../../profiles/readme.md

output-folder: $(azureresourceschema-folder)/schemas

# all the input files across all versions
input-file:
  - Microsoft.RecoveryServices/stable/2018-07-10/service.json
  - Microsoft.RecoveryServices/stable/2018-01-10/service.json
  - Microsoft.RecoveryServices/stable/2016-08-10/service.json

```
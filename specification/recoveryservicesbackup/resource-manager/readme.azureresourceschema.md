## AzureResourceSchema

These settings apply only when `--azureresourceschema` is specified on the command line.

### AzureResourceSchema multi-api

``` yaml $(azureresourceschema) && $(multiapi)
# include the azure profile definitions from the standard location
require: ../../../profiles/readme.md

output-folder: $(azureresourceschema-folder)/schemas

# all the input files across all versions
input-file:
  - Microsoft.RecoveryServices/stable/2020-07-01/bms.json
  - Microsoft.RecoveryServices/stable/2020-02-02/bms.json
  - Microsoft.RecoveryServices/stable/2019-06-15/bms.json
  - Microsoft.RecoveryServices/stable/2017-07-01/bms.json
  - Microsoft.RecoveryServices/stable/2016-12-01/bms.json
  - Microsoft.RecoveryServices/stable/2016-08-10/operations.json
  - Microsoft.RecoveryServices/stable/2019-05-13/bms.json
  - Microsoft.RecoveryServices/stable/2018-12-20/bms.json
  - Microsoft.RecoveryServices/stable/2016-06-01/recoveryservicesbackup.json
  - Microsoft.RecoveryServices/stable/2016-06-01/registeredIdentities.json

```
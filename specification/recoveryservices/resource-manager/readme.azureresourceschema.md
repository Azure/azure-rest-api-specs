## AzureResourceSchema

These settings apply only when `--azureresourceschema` is specified on the command line.

### AzureResourceSchema multi-api

``` yaml $(azureresourceschema) && $(multiapi)
# include the azure profile definitions from the standard location
require: ../../../profiles/readme.md

output-folder: $(azureresourceschema-folder)/schemas

# all the input files across all versions
input-file:
  - Microsoft.RecoveryServices/stable/2016-06-01/registeredidentities.json
  - Microsoft.RecoveryServices/stable/2016-06-01/replicationusages.json
  - Microsoft.RecoveryServices/stable/2016-06-01/vaults.json
  - Microsoft.RecoveryServices/stable/2016-06-01/vaultusages.json

```
## AzureResourceSchema

These settings apply only when `--azureresourceschema` is specified on the command line.

### AzureResourceSchema multi-api

``` yaml $(azureresourceschema) && $(multiapi)
# include the azure profile definitions from the standard location
require: ../../../profiles/readme.md

output-folder: $(azureresourceschema-folder)/schemas

# all the input files across all versions
input-file:
  - Microsoft.KeyVault/stable/2019-09-01/keyvault.json
  - Microsoft.KeyVault/stable/2019-09-01/providers.json
  - Microsoft.KeyVault/preview/2020-04-01-preview/managedHsm.json
  - Microsoft.KeyVault/preview/2020-04-01-preview/keyvault.json
  - Microsoft.KeyVault/preview/2020-04-01-preview/providers.json
  - Microsoft.KeyVault/preview/2020-04-01-preview/secrets.json
  - Microsoft.KeyVault/preview/2018-02-14-preview/keyvault.json
  - Microsoft.KeyVault/preview/2018-02-14-preview/providers.json
  - Microsoft.KeyVault/stable/2018-02-14/keyvault.json
  - Microsoft.KeyVault/stable/2018-02-14/providers.json
  - Microsoft.KeyVault/stable/2016-10-01/keyvault.json
  - Microsoft.KeyVault/stable/2016-10-01/providers.json
  - Microsoft.KeyVault/stable/2015-06-01/keyvault.json

```
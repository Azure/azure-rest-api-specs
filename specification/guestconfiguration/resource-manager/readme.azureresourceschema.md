## AzureResourceSchema

These settings apply only when `--azureresourceschema` is specified on the command line.

### AzureResourceSchema multi-api

``` yaml $(azureresourceschema) && $(multiapi)
# include the azure profile definitions from the standard location
require: ../../../profiles/readme.md

output-folder: $(azureresourceschema-folder)/schemas

# all the input files across all versions
input-file:
  - Microsoft.GuestConfiguration/stable/2020-06-25/guestconfiguration.json
  - Microsoft.GuestConfiguration/stable/2018-11-20/guestconfiguration.json
  - Microsoft.GuestConfiguration/preview/2018-06-30-preview/guestconfiguration.json
  - Microsoft.GuestConfiguration/preview/2018-01-20-preview/guestconfiguration.json

```
## AzureResourceSchema

These settings apply only when `--azureresourceschema` is specified on the command line.

### AzureResourceSchema multi-api

``` yaml $(azureresourceschema) && $(multiapi)
# include the azure profile definitions from the standard location
require: ../../../profiles/readme.md

output-folder: $(azureresourceschema-folder)/schemas

# all the input files across all versions
input-file:
  - Microsoft.ManagedServices/preview/2020-02-01-preview/managedservices.json
  - Microsoft.ManagedServices/stable/2019-09-01/managedservices.json
  - Microsoft.ManagedServices/stable/2019-06-01/managedservices.json
  - Microsoft.ManagedServices/preview/2019-04-01-preview/managedservices.json
  - Microsoft.ManagedServices/preview/2018-06-01-preview/managedservices.json

```
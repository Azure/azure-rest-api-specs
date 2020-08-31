## AzureResourceSchema

These settings apply only when `--azureresourceschema` is specified on the command line.

### AzureResourceSchema multi-api

``` yaml $(azureresourceschema) && $(multiapi)
# include the azure profile definitions from the standard location
require: ../../../profiles/readme.md

output-folder: $(azureresourceschema-folder)/schemas

# all the input files across all versions
input-file:
  - Microsoft.AzureStack/stable/2017-06-01/AzureStack.json
  - Microsoft.AzureStack/stable/2017-06-01/Product.json
  - Microsoft.AzureStack/stable/2017-06-01/Registration.json
  - Microsoft.AzureStack/stable/2017-06-01/CustomerSubscription.json

```
## AzureResourceSchema

These settings apply only when `--azureresourceschema` is specified on the command line.

### AzureResourceSchema multi-api

``` yaml $(azureresourceschema) && $(multiapi)
# include the azure profile definitions from the standard location
require: ../../../profiles/readme.md

output-folder: $(azureresourceschema-folder)/schemas

# all the input files across all versions
input-file:
  - Microsoft.AAD/stable/2020-01-01/domainservices.json
  - Microsoft.AAD/stable/2020-01-01/oucontainer.json
  - Microsoft.AAD/stable/2017-06-01/domainservices.json
  - Microsoft.AAD/stable/2017-06-01/oucontainer.json
  - Microsoft.AAD/stable/2017-01-01/domainservices.json

```
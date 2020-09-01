## AzureResourceSchema

These settings apply only when `--azureresourceschema` is specified on the command line.

### AzureResourceSchema multi-api

``` yaml $(azureresourceschema) && $(multiapi)
# include the azure profile definitions from the standard location
require: ../../../profiles/readme.md

output-folder: $(azureresourceschema-folder)/schemas

# all the input files across all versions
input-file:
  - Microsoft.Management/stable/2020-05-01/management.json
  - Microsoft.Management/stable/2020-02-01/management.json
  - Microsoft.Management/stable/2019-11-01/management.json
  - Microsoft.Management/preview/2018-03-01-preview/management.json
  - Microsoft.Management/preview/2018-01-01-preview/management.json
  - Microsoft.Management/preview/2017-11-01-preview/management.json
  - Microsoft.Management/preview/2017-08-31-preview/management.json

```
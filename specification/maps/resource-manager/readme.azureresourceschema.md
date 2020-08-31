## AzureResourceSchema

These settings apply only when `--azureresourceschema` is specified on the command line.

### AzureResourceSchema multi-api

``` yaml $(azureresourceschema) && $(multiapi)
# include the azure profile definitions from the standard location
require: ../../../profiles/readme.md

output-folder: $(azureresourceschema-folder)/schemas

# all the input files across all versions
input-file:
  - Microsoft.Maps/preview/2020-02-01-preview/maps-management.json
  - Microsoft.Maps/stable/2017-01-01-preview/maps-management.json
  - Microsoft.Maps/stable/2018-05-01/maps-management.json

```
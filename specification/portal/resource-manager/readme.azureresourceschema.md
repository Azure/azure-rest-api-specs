## AzureResourceSchema

These settings apply only when `--azureresourceschema` is specified on the command line.

### AzureResourceSchema multi-api

``` yaml $(azureresourceschema) && $(multiapi)
# include the azure profile definitions from the standard location
require: ../../../profiles/readme.md

output-folder: $(azureresourceschema-folder)/schemas

# all the input files across all versions
input-file:
  - Microsoft.Portal/preview/2019-01-01-preview/portal.json
  - Microsoft.Portal/preview/2018-10-01-preview/portal.json
  - Microsoft.Portal/preview/2015-08-01-preview/portal.json

```
## AzureResourceSchema

These settings apply only when `--azureresourceschema` is specified on the command line.

### AzureResourceSchema multi-api

``` yaml $(azureresourceschema) && $(multiapi)
# include the azure profile definitions from the standard location
require: ../../../profiles/readme.md

output-folder: $(azureresourceschema-folder)/schemas

# all the input files across all versions
input-file:
  - Microsoft.Peering/stable/2020-04-01/peering.json
  - Microsoft.Peering/preview/2020-01-01-preview/peering.json
  - Microsoft.Peering/preview/2019-09-01-preview/peering.json
  - Microsoft.Peering/preview/2019-08-01-preview/peering.json

```
## AzureResourceSchema

These settings apply only when `--azureresourceschema` is specified on the command line.

### AzureResourceSchema multi-api

``` yaml $(azureresourceschema) && $(multiapi)
# include the azure profile definitions from the standard location
require: ../../../profiles/readme.md

output-folder: $(azureresourceschema-folder)/schemas

# all the input files across all versions
input-file:
  - Microsoft.DataBox/stable/2020-04-01/databox.json
  - Microsoft.DataBox/stable/2019-09-01/databox.json
  - Microsoft.DataBox/stable/2018-01-01/databox.json

```
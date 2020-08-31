## AzureResourceSchema

These settings apply only when `--azureresourceschema` is specified on the command line.

### AzureResourceSchema multi-api

``` yaml $(azureresourceschema) && $(multiapi)
# include the azure profile definitions from the standard location
require: ../../../profiles/readme.md

output-folder: $(azureresourceschema-folder)/schemas

# all the input files across all versions
input-file:
  - Microsoft.Logic/stable/2019-05-01/logic.json
  - Microsoft.Logic/preview/2018-07-01-preview/logic.json
  - Microsoft.Logic/stable/2016-06-01/logic.json
  - Microsoft.Logic/preview/2015-08-01-preview/logic.json
  - Microsoft.Logic/preview/2015-02-01-preview/logic.json

```
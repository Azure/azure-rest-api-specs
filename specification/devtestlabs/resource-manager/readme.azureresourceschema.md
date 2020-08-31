## AzureResourceSchema

These settings apply only when `--azureresourceschema` is specified on the command line.

### AzureResourceSchema multi-api

``` yaml $(azureresourceschema) && $(multiapi)
# include the azure profile definitions from the standard location
require: ../../../profiles/readme.md

output-folder: $(azureresourceschema-folder)/schemas

# all the input files across all versions
input-file:
  - Microsoft.DevTestLab/stable/2018-09-15/DTL.json
  - Microsoft.DevTestLab/stable/2016-05-15/DTL.json
  - Microsoft.DevTestLab/preview/2015-05-21-preview/DTL.json

```
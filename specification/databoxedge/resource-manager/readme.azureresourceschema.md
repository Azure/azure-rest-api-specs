## AzureResourceSchema

These settings apply only when `--azureresourceschema` is specified on the command line.

### AzureResourceSchema multi-api

``` yaml $(azureresourceschema) && $(multiapi)
# include the azure profile definitions from the standard location
require: ../../../profiles/readme.md

output-folder: $(azureresourceschema-folder)/schemas

# all the input files across all versions
input-file:
  - Microsoft.DataBoxEdge/preview/2020-05-01-preview/databoxedge.json
  - Microsoft.DataBoxEdge/stable/2019-08-01/databoxedge.json
  - Microsoft.DataBoxEdge/stable/2019-07-01/databoxedge.json
  - Microsoft.DataBoxEdge/stable/2019-03-01/databoxedge.json

```
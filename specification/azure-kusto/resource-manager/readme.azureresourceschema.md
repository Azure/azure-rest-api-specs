## AzureResourceSchema

These settings apply only when `--azureresourceschema` is specified on the command line.

### AzureResourceSchema multi-api

``` yaml $(azureresourceschema) && $(multiapi)
# include the azure profile definitions from the standard location
require: ../../../profiles/readme.md

output-folder: $(azureresourceschema-folder)/schemas

# all the input files across all versions
input-file:
  - Microsoft.Kusto/stable/2020-06-14/kusto.json
  - Microsoft.Kusto/stable/2020-02-15/kusto.json
  - Microsoft.Kusto/stable/2019-11-09/kusto.json
  - Microsoft.Kusto/stable/2019-09-07/kusto.json
  - Microsoft.Kusto/stable/2019-05-15/kusto.json
  - Microsoft.Kusto/stable/2019-01-21/kusto.json
  - Microsoft.Kusto/preview/2018-09-07-preview/kusto.json
  - Microsoft.Kusto/preview/2017-09-07-privatepreview/kusto.json

```
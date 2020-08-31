## AzureResourceSchema

These settings apply only when `--azureresourceschema` is specified on the command line.

### AzureResourceSchema multi-api

``` yaml $(azureresourceschema) && $(multiapi)
# include the azure profile definitions from the standard location
require: ../../../profiles/readme.md

output-folder: $(azureresourceschema-folder)/schemas

# all the input files across all versions
input-file:
  - Microsoft.Search/stable/2020-08-01/search.json
  - Microsoft.Search/stable/2020-03-13/search.json
  - Microsoft.Search/stable/2015-08-19/search.json
  - Microsoft.Search/stable/2015-02-28/search.json
  - Microsoft.Search/preview/2020-08-01-preview/search.json
  - Microsoft.Search/preview/2019-10-01-preview/search.json

```
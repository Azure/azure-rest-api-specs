## AzureResourceSchema

These settings apply only when `--azureresourceschema` is specified on the command line.

### AzureResourceSchema multi-api

``` yaml $(azureresourceschema) && $(multiapi)
# include the azure profile definitions from the standard location
require: ../../../profiles/readme.md

output-folder: $(azureresourceschema-folder)/schemas

# all the input files across all versions
input-file:
  - Microsoft.AppConfiguration/stable/2020-06-01/appconfiguration.json
  - Microsoft.AppConfiguration/preview/2019-11-01-preview/appconfiguration.json
  - Microsoft.AppConfiguration/preview/2019-02-01-preview/appconfiguration.json
  - Microsoft.AppConfiguration/stable/2019-10-01/appconfiguration.json

```
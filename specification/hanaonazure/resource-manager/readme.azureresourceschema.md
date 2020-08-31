## AzureResourceSchema

These settings apply only when `--azureresourceschema` is specified on the command line.

### AzureResourceSchema multi-api

``` yaml $(azureresourceschema) && $(multiapi)
# include the azure profile definitions from the standard location
require: ../../../profiles/readme.md

output-folder: $(azureresourceschema-folder)/schemas

# all the input files across all versions
input-file:
  - Microsoft.HanaOnAzure/preview/2017-11-03-preview/hanaonazure.json
  - Microsoft.HanaOnAzure/preview/2020-02-07-preview/hanaonazure.json

```
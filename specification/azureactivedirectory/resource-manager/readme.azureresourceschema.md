## AzureResourceSchema

These settings apply only when `--azureresourceschema` is specified on the command line.

### AzureResourceSchema multi-api

``` yaml $(azureresourceschema) && $(multiapi)
# include the azure profile definitions from the standard location
require: ../../../profiles/readme.md

output-folder: $(azureresourceschema-folder)/schemas

# all the input files across all versions
input-file:
  - Microsoft.Aadiam/preview/2020-07-01-preview/azureADMetrics.json
  - Microsoft.Aadiam/preview/2020-03-01-preview/privateLinkForAzureAD.json
  - Microsoft.Aadiam/preview/2020-03-01-preview/privateLinkResources.json
  - Microsoft.Aadiam/stable/2017-04-01/azureactivedirectory.json

```
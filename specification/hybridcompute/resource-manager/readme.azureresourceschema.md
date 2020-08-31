## AzureResourceSchema

These settings apply only when `--azureresourceschema` is specified on the command line.

### AzureResourceSchema multi-api

``` yaml $(azureresourceschema) && $(multiapi)
# include the azure profile definitions from the standard location
require: ../../../profiles/readme.md

output-folder: $(azureresourceschema-folder)/schemas

# all the input files across all versions
input-file:
  - Microsoft.HybridCompute/preview/2019-03-18/HybridCompute.json
  - Microsoft.HybridCompute/preview/2019-08-02/HybridCompute.json
  - Microsoft.HybridCompute/stable/2019-12-12/HybridCompute.json
  - Microsoft.HybridCompute/preview/2020-07-30-preview/HybridCompute.json
  - Microsoft.HybridCompute/stable/2020-08-02/HybridCompute.json

```
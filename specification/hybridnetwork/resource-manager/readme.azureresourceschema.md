## AzureResourceSchema

These settings apply only when `--azureresourceschema` is specified on the command line.

### AzureResourceSchema multi-api

``` yaml $(azureresourceschema) && $(multiapi)
# include the azure profile definitions from the standard location
require: ../../../profiles/readme.md

output-folder: $(azureresourceschema-folder)/schemas

# all the input files across all versions
input-file:
  - Microsoft.HybridNetwork/preview/2020-01-01-preview/common.json
  - Microsoft.HybridNetwork/preview/2020-01-01-preview/virtualNetworkFunction.json
  - Microsoft.HybridNetwork/preview/2020-01-01-preview/device.json
  - Microsoft.HybridNetwork/preview/2020-01-01-preview/operations.json
  - Microsoft.HybridNetwork/preview/2020-01-01-preview/vendor.json
  - Microsoft.HybridNetwork/preview/2020-01-01-preview/virtualNetworkFunctionVendors.json

```
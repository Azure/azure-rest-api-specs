## AzureResourceSchema

These settings apply only when `--azureresourceschema` is specified on the command line.

### AzureResourceSchema multi-api

``` yaml $(azureresourceschema) && $(multiapi)
batch:
  - tag: schema-hybridnetwork-2020-01-01-preview

```

Please also specify `--azureresourceschema-folder=<path to the root directory of your azure-resource-manager-schemas clone>`.

### Tag: schema-hybridnetwork-2020-01-01-preview and azureresourceschema

``` yaml $(tag) == 'schema-hybridnetwork-2020-01-01-preview' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.HybridNetwork/preview/2020-01-01-preview/common.json
  - Microsoft.HybridNetwork/preview/2020-01-01-preview/virtualNetworkFunction.json
  - Microsoft.HybridNetwork/preview/2020-01-01-preview/device.json
  - Microsoft.HybridNetwork/preview/2020-01-01-preview/operations.json
  - Microsoft.HybridNetwork/preview/2020-01-01-preview/vendor.json
  - Microsoft.HybridNetwork/preview/2020-01-01-preview/virtualNetworkFunctionVendors.json

```

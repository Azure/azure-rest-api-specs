## C#

These settings apply only when `--csharp` is specified on the command line.
Please also specify `--csharp-sdks-folder=<path to "SDKs" directory of your azure-sdk-for-net clone>`.

``` yaml $(csharp)
csharp:
  azure-arm: true
  license-header: MICROSOFT_MIT_NO_VERSION
  namespace: Microsoft.Azure.Management.CosmosDB
  output-folder: $(csharp-sdks-folder)/cosmosdb/Microsoft.Azure.Management.CosmosDB/src/Generated
  clear-output-folder: true
```

``` yaml $(csharp) && !$(multiapi) && !$(csharp-profile)
namespace: Microsoft.Azure.Management.CosmosDB
output-folder: $(csharp-sdks-folder)/cosmosdb/Microsoft.Azure.Management.CosmosDB/src/Generated
```
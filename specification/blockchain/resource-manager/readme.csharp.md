## C# 

These settings apply only when `--csharp` is specified on the command line.
Please also specify `--csharp-sdks-folder=<path to "SDKs" directory of your azure-sdk-for-net clone>`.

``` yaml $(csharp)
csharp:
  azure-arm: true
  license-header: MICROSOFT_MIT_NO_VERSION
  namespace: Microsoft.Azure.Management.Blockchain
  payload-flattening-threshold: 2
  output-folder: $(csharp-sdks-folder)/blockchain/Microsoft.Azure.Management.Blockchain/src/Generated
  clear-output-folder: true
```

## C

These settings apply only when `--csharp` is specified on the command line.
Please also specify `--csharp-sdks-folder=<path to "sdk" directory of your azure-sdk-for-net clone>`.

```yaml $(csharp)
csharp:
  azure-arm: true
  license-header: MICROSOFT_MIT_NO_VERSION
  payload-flattening-threshold: 1
  clear-output-folder: true
  client-side-validation: false
  namespace:  Microsoft.Azure.Management.AzureArcData
  output-folder: D:\workspace\azure-rest-api-specs\specification\azurearcdata\resource-manager\Microsoft.Azure.Management.AzureArcData\src\Generated
```

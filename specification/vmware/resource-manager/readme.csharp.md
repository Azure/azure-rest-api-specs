## C#

These settings apply only when `--csharp` is specified on the command line.
Please also specify `--csharp-sdks-folder=<path to "SDKs" directory of your azure-sdk-for-net clone>`.

```yaml $(csharp)
csharp:
  azure-arm: true
  license-header: MICROSOFT_MIT_NO_VERSION
  clear-output-folder: true
  namespace: Microsoft.Azure.Management.Avs
  override-client-name: AvsClient
  output-folder: $(csharp-sdks-folder)/avs/Microsoft.Azure.Management.Avs/src/Generated
```

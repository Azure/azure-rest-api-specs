## C#

These settings apply only when `--csharp` is specified on the command line.
Please also specify `--csharp-sdks-folder=<path to "SDKs" directory of your azure-sdk-for-net clone>`.

```yaml $(csharp)
csharp:
<<<<<<< HEAD
  azure-arm: true
  license-header: MICROSOFT_MIT_NO_VERSION
  clear-output-folder: true
  namespace: Microsoft.Azure.Management.Avs
  override-client-name: AvsClient
  output-folder: $(csharp-sdks-folder)/avs/Microsoft.Azure.Management.Avs/src/Generated
```
=======
  package-version: 0.3.0
  azure-arm: true
  license-header: MICROSOFT_MIT_NO_VERSION
  payload-flattening-threshold: 2
  clear-output-folder: true
  namespace: Microsoft.Azure.Management.VMware
  output-folder: $(csharp-sdks-folder)/VMware/Management.VMware/Generated
```
>>>>>>> 4ea1e0abb0265a95f3f49494d2f0815b6be6d7d6

## C

These settings apply only when `--csharp` is specified on the command line.
Please also specify `--csharp-sdks-folder=<path to "SDKs" directory of your azure-sdk-for-net clone>`.

```yaml $(csharp)
csharp:
  azure-arm: false
  public-clients: true
  license-header: MICROSOFT_MIT_SMALL_NO_CODEGEN
  payload-flattening-threshold: 1
  clear-output-folder: true
  client-side-validation: false
  namespace: Azure.Iot.DeviceUpdate
  output-folder: $(csharp-sdks-folder)/deviceupdate/Azure.Iot.DeviceUpdate/src/Generated
```

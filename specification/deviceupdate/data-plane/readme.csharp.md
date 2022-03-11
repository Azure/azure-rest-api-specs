## csharp

These settings apply only when `--csharp` is specified on the command line.
Please also specify `--csharp-sdks-folder=<path to "SDKs" directory of your azure-sdk-for-net clone>`.

```yaml $(csharp)
public-clients: true
title: DeviceUpdate
namespace: Azure.IoT.DeviceUpdate
data-plane: true
security: AADToken
security-scopes:  https://api.adu.microsoft.com/.default
output-folder: $(csharp-sdks-folder)/sdk/deviceupdate/$(namespace)/src/Generated
```
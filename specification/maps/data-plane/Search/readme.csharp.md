## C#

These settings apply only when `--csharp` is specified on the command line.
Please also specify `--csharp-sdks-folder=<path to "SDKs" directory of your azure-sdk-for-net clone>`.

```yaml $(csharp)
sync-methods: None
license-header: MICROSOFT_MIT_NO_VERSION
namespace: Azure.Maps.Search
output-folder: $(csharp-sdks-folder)/maps/Azure.Maps.Search/src/Generated
clear-output-folder: true
public-clients: true
```
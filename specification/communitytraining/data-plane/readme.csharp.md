## C#

These settings apply only when `--csharp` is specified on the command line.
Please also specify `--csharp-sdks-folder=<path to "SDKs" directory of your azure-sdk-for-net clone>`.

```yaml $(csharp)
sync-methods: None
license-header: MICROSOFT_MIT_NO_VERSION
namespace: azure.community-training
output-folder: $(csharp-sdks-folder)/community-training/azure-dataplane-community-training/src/generated
clear-output-folder: true
public-clients: true
```
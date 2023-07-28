## C#

These settings apply only when `--csharp` is specified on the command line.
Please also specify `--csharp-sdks-folder=<path to "SDKs" directory of your azure-sdk-for-net clone>`.

```yaml $(csharp)
azure-arm: true
license-header: MICROSOFT_MIT_NO_VERSION
payload-flattening-threshold: 1
clear-output-folder: true
client-side-validation: false
namespace: Microsoft.SharePoint.Syntex.Client
output-folder: $(csharp-sdks-folder)/syntex/management/Microsoft.SharePoint.Syntex.Client/GeneratedProtocol
directive:
  from: swagger-document
  where: $.definitions.*
  transform: >
    $["x-accessibility"] = "public"
```

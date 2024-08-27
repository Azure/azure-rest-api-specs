## C#

These settings apply only when `--csharp` is specified on the command line.
Please also specify `--csharp-sdks-folder=<path to "SDKs" directory of your azure-sdk-for-net clone>`.

```yaml $(csharp)

csharp:
  azure-arm: false
  license-header: MICROSOFT_MIT_NO_VERSION
  client-side-validation: false

payload-flattening-threshold: 2
namespace: "Microsoft.Azure.DevCenter"
output-folder: "$(csharp-sdks-folder)/devcenter/data-plane/src/generated"
public-clients: true

csharp/simplifier:
  plugin: csharp-simplifier
  input: generate
  output-artifact: source-file-csharp
  suffixes:
    - ""
```
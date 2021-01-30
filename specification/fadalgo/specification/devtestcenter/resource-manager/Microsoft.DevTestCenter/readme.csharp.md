## C

These settings apply only when `--csharp` is specified on the command line.
Please also specify `--csharp-sdks-folder=<path to "SDKs" directory of your azure-sdk-for-net clone>`.

```yaml $(csharp)
csharp:
  azure-arm: true
  license-header: MICROSOFT_MIT_NO_VERSION
  payload-flattening-threshold: 2
  client-side-validation: false
  namespace: Microsoft.DevTestCenter.Sdk_v2021_01_01_alpha
  output-folder: $(csharp-sdks-folder)/$(tag)
  
csharp/simplifier:
  plugin: csharp-simplifier
  input: generate
  output-artifact: source-file-csharp
  suffixes:
    - ""
```
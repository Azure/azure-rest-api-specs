## C#

These settings apply only when `--csharp` is specified on the command line.
Please also specify `--csharp-sdks-folder=<path to "SDKs" directory of your azure-sdk-for-net clone>`.

```yaml $(csharp)
csharp:
  license-header: MICROSOFT_MIT_NO_VERSION
  clear-output-folder: true
  namespace: Azure.Quantum.Jobs
  output-folder: $(csharp-sdks-folder)/quantum/Azure.Quantum.Jobs/src/Generated
```

## CSharp

These settings apply only when `--csharp` is specified on the command line.
Please also specify `--csharp-sdks-folder=<path to "SDKs" directory of your azure-sdk-for-net clone>`.

```yaml $(csharp)
csharp:
  sync-methods: None  
  license-header: MICROSOFT_MIT_NO_VERSION
  azure-arm: false  
  namespace: Microsoft.Azure.CognitiveServices.InkRecognizer
  output-folder: $(csharp-sdks-folder)/CognitiveServices/dataPlane/InkRecognizer/InkRecognizer/Generated
  clear-output-folder: true
```

## C## C# EdgeActions



These settings apply only when `--csharp` is specified on the command line.These settings apply only when `--csharp` is specified on the command line.

Please also specify `--csharp-sdks-folder=<path to "SDKs" directory of your azure-sdk-for-net clone>`.Please also specify `--csharp-sdks-folder=<path to "SDKs" directory of your azure-sdk-for-net clone>`.



```yaml $(csharp)```yaml $(csharp)

azure-arm: truecsharp:

license-header: MICROSOFT_MIT_NO_VERSION  azure-arm: true

payload-flattening-threshold: 2  license-header: MICROSOFT_MIT_NO_VERSION

clear-output-folder: true  namespace: Azure.ResourceManager.EdgeActions

namespace: Microsoft.Azure.Management.Cdn  output-folder: $(csharp-sdks-folder)/edgeactions/Azure.ResourceManager.EdgeActions/src/Generated

output-folder: $(csharp-sdks-folder)/cdn/Microsoft.Azure.Management.Cdn/src/Generated  clear-output-folder: true

modelerfour:```

  lenient-model-deduplication: true
```

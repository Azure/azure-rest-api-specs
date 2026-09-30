## Java

These settings apply only when `--java` is specified on the command line.
Please also specify `--azure-libraries-for-java-folder=<path to the root directory of your azure-libraries-for-java clone>`.

``` yaml $(java)
azure-arm: true
fluent: true
namespace: com.microsoft.azure.management.previewalertrule
license-header: MICROSOFT_MIT_NO_CODEGEN
payload-flattening-threshold: 1
output-folder: $(azure-libraries-for-java-folder)/azure-mgmt-previewalertrule
```

### Java multi-api

``` yaml $(java) && $(multiapi)
batch:
  - tag: package-preview-2025-07
  - tag: package-preview-2025-05
```

### Tag: package-preview-2025-07 and java

These settings apply only when `--tag=package-preview-2025-07 --java` is specified on the command line.
Please also specify `--azure-libraries-for-java-folder=<path to the root directory of your azure-sdk-for-java clone>`.

``` yaml $(tag)=='package-preview-2025-07' && $(java) && $(multiapi)
java:
  namespace: com.microsoft.azure.management.previewalertrule.v2025_07_01_preview
  output-folder: $(azure-libraries-for-java-folder)/sdk/previewalertrule/mgmt-v2025_07_01_preview
regenerate-manager: true
generate-interface: true
```

### Tag: package-preview-2025-05 and java

These settings apply only when `--tag=package-preview-2025-05 --java` is specified on the command line.
Please also specify `--azure-libraries-for-java-folder=<path to the root directory of your azure-sdk-for-java clone>`.

``` yaml $(tag)=='package-preview-2025-05' && $(java) && $(multiapi)
java:
  namespace: com.microsoft.azure.management.previewalertrule.v2025_05_01_preview
  output-folder: $(azure-libraries-for-java-folder)/sdk/previewalertrule/mgmt-v2025_05_01_preview
regenerate-manager: true
generate-interface: true
```

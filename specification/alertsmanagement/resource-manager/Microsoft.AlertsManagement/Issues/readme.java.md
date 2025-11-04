## Java

These settings apply only when `--java` is specified on the command line.
Please also specify `--azure-libraries-for-java-folder=<path to the root directory of your azure-libraries-for-java clone>`.

``` yaml $(java)
azure-arm: true
fluent: true
namespace: com.microsoft.azure.management.issues
license-header: MICROSOFT_MIT_NO_CODEGEN
payload-flattening-threshold: 1
output-folder: $(azure-libraries-for-java-folder)/azure-mgmt-issues
```

### Java multi-api

``` yaml $(java) && $(multiapi)
batch:
  - tag: package-preview-2025-03
```

### Tag: package-preview-2025-03 and java

These settings apply only when `--tag=package-preview-2025-03 --java` is specified on the command line.
Please also specify `--azure-libraries-for-java-folder=<path to the root directory of your azure-sdk-for-java clone>`.

``` yaml $(tag)=='package-preview-2025-03' && $(java) && $(multiapi)
java:
  namespace: com.microsoft.azure.management.issues.v2025_03_01_preview
  output-folder: $(azure-libraries-for-java-folder)/sdk/issues/mgmt-v2025_03_01_preview
regenerate-manager: true
generate-interface: true
```

## Java

These settings apply only when `--java` is specified on the command line.
Please also specify `--azure-libraries-for-java-folder=<path to the root directory of your azure-libraries-for-java clone>`.

``` yaml $(java)
azure-arm: true
fluent: true
namespace: com.microsoft.azure.management.tenantactivitylogalerts
license-header: MICROSOFT_MIT_NO_CODEGEN
payload-flattening-threshold: 1
output-folder: $(azure-libraries-for-java-folder)/azure-mgmt-tenantactivitylogalerts
```

### Java multi-api

``` yaml $(java) && $(multiapi)
batch:
  - tag: package-preview-2023-04
```

### Tag: package-preview-2023-04 and java

These settings apply only when `--tag=package-preview-2023-04 --java` is specified on the command line.
Please also specify `--azure-libraries-for-java-folder=<path to the root directory of your azure-sdk-for-java clone>`.

``` yaml $(tag)=='package-preview-2023-04' && $(java) && $(multiapi)
java:
  namespace: com.microsoft.azure.management.tenantactivitylogalerts.v2023_04_01_preview
  output-folder: $(azure-libraries-for-java-folder)/sdk/tenantactivitylogalerts/mgmt-v2023_04_01_preview
regenerate-manager: true
generate-interface: true
```

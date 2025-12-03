## Java

These settings apply only when `--java` is specified on the command line.
Please also specify `--azure-libraries-for-java-folder=<path to the root directory of your azure-libraries-for-java clone>`.

``` yaml $(java)
azure-arm: true
fluent: true
namespace: com.microsoft.azure.management.alertrulerecommendations
license-header: MICROSOFT_MIT_NO_CODEGEN
payload-flattening-threshold: 1
output-folder: $(azure-libraries-for-java-folder)/azure-mgmt-alertrulerecommendations
```

### Java multi-api

``` yaml $(java) && $(multiapi)
batch:
  - tag: package-preview-2023-08
  - tag: package-preview-2023-01
```

### Tag: package-preview-2023-08 and java

These settings apply only when `--tag=package-preview-2023-08 --java` is specified on the command line.
Please also specify `--azure-libraries-for-java-folder=<path to the root directory of your azure-sdk-for-java clone>`.

``` yaml $(tag)=='package-preview-2023-08' && $(java) && $(multiapi)
java:
  namespace: com.microsoft.azure.management.alertrulerecommendations.v2023_08_01_preview
  output-folder: $(azure-libraries-for-java-folder)/sdk/alertrulerecommendations/mgmt-v2023_08_01_preview
regenerate-manager: true
generate-interface: true
```

### Tag: package-preview-2023-01 and java

These settings apply only when `--tag=package-preview-2023-01 --java` is specified on the command line.
Please also specify `--azure-libraries-for-java-folder=<path to the root directory of your azure-sdk-for-java clone>`.

``` yaml $(tag)=='package-preview-2023-01' && $(java) && $(multiapi)
java:
  namespace: com.microsoft.azure.management.alertrulerecommendations.v2023_01_01_preview
  output-folder: $(azure-libraries-for-java-folder)/sdk/alertrulerecommendations/mgmt-v2023_01_01_preview
regenerate-manager: true
generate-interface: true
```

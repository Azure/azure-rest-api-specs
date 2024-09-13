## Java

These settings apply only when `--java` is specified on the command line.
Please also specify `--azure-libraries-for-java-folder=<path to the root directory of your azure-libraries-for-java clone>`.

``` yaml $(java)
azure-arm: true
fluent: true
namespace: com.microsoft.azure.management.quota
license-header: MICROSOFT_MIT_NO_CODEGEN
payload-flattening-threshold: 1
output-folder: $(azure-libraries-for-java-folder)/azure-mgmt-quota
```

### Java multi-api

```yaml $(java) && $(multiapi)
batch:
  - tag: package-2024-10-01
  - tag: package-preview-2024-05
```

### Tag: package-2023-02-01 and java

These settings apply only when `--tag=package-2023-02-01 --java` is specified on the command line.
Please also specify `--azure-libraries-for-java-folder=<path to the root directory of your azure-sdk-for-java clone>`.

``` yaml $(tag) == 'package-2023-02-01' && $(java) && $(multiapi)
java:
  namespace: com.microsoft.azure.management.quota.v2023_02_01
  output-folder: $(azure-libraries-for-java-folder)/sdk/quota/mgmt-v2023_02_01
regenerate-manager: true
generate-interface: true
```

### Tag: package-preview-2024-05 and java

These settings apply only when `--tag=package-preview-2024-05 --java` is specified on the command line.
Please also specify `--azure-libraries-for-java-folder=<path to the root directory of your azure-sdk-for-java clone>`.

``` yaml $(tag) == 'package-preview-2024-05' && $(java) && $(multiapi)
java:
  namespace: com.microsoft.azure.management.quota.v2023_06_01_preview
  output-folder: $(azure-libraries-for-java-folder)/sdk/quota/mgmt-v2024_05_preview
regenerate-manager: true
generate-interface: true
```

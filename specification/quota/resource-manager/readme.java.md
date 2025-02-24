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
  - tag: package-2023-02-01
  - tag: package-2023-06-01-preview
  - tag: package-2024-10-15-preview
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

### Tag: package-2023-06-01-preview and java

These settings apply only when `--tag=package-2023-06-01-preview --java` is specified on the command line.
Please also specify `--azure-libraries-for-java-folder=<path to the root directory of your azure-sdk-for-java clone>`.

``` yaml $(tag) == 'package-2023-06-01-preview' && $(java) && $(multiapi)
java:
  namespace: com.microsoft.azure.management.quota.v2023_06_01_preview
  output-folder: $(azure-libraries-for-java-folder)/sdk/quota/mgmt-v2023_06_01_preview
regenerate-manager: true
generate-interface: true
```

### Tag: package-2024-10-15-preview and java

These settings apply only when `--tag=package-2024-10-15-preview --java` is specified on the command line.
Please also specify `--azure-libraries-for-java-folder=<path to the root directory of your azure-sdk-for-java clone>`.

``` yaml $(tag) == 'package-2024-10-15-preview' && $(java) && $(multiapi)
java:
  namespace: com.microsoft.azure.management.quota.v2024_10_15_preview
  output-folder: $(azure-libraries-for-java-folder)/sdk/quota/mgmt-v2024_10_15_preview
regenerate-manager: true
generate-interface: true
```

### Tag: package-2021-03-15-preview and java

These settings apply only when `--tag=package-2021-03-15-preview --java` is specified on the command line.
Please also specify `--azure-libraries-for-java-folder=<path to the root directory of your azure-sdk-for-java clone>`.

``` yaml $(tag) == 'package-2021-03-15-preview' && $(java) && $(multiapi)
java:
  namespace: com.microsoft.azure.management.quota.v2021_03_15_preview
  output-folder: $(azure-libraries-for-java-folder)/sdk/quota/mgmt-v2021_03_15_preview
regenerate-manager: true
generate-interface: true
```
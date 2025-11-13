## Java

These settings apply only when `--java` is specified on the command line.
Please also specify `--azure-libraries-for-java-folder=<path to the root directory of your azure-libraries-for-java clone>`.

``` yaml $(java)
azure-arm: true
fluent: true
namespace: com.microsoft.azure.management.datadog
license-header: MICROSOFT_MIT_NO_CODEGEN
payload-flattening-threshold: 1
output-folder: $(azure-libraries-for-java-folder)/azure-mgmt-datadog
```

### Java multi-api

``` yaml $(java) && $(multiapi)
batch:
  - tag: package-2025-06
  - tag: package-2025-01
  - tag: package-2024-03
  - tag: package-2023-01
  - tag: packag-2022-08
  - tag: package-2022-06
  - tag: package-2021-03
  - tag: package-2020-02-preview
```

### Tag: package-2025-06 and java

These settings apply only when `--tag=package-2025-06 --java` is specified on the command line.
Please also specify `--azure-libraries-for-java=<path to the root directory of your azure-sdk-for-java clone>`.

``` yaml $(tag) == 'package-2025-06' && $(java) && $(multiapi)
java:
  namespace: com.microsoft.azure.management.datadog.v2025_06_11
  output-folder: $(azure-libraries-for-java-folder)/sdk/datadog/mgmt-v2025_06_11
regenerate-manager: true
generate-interface: true
```

### Tag: package-2025-01 and java

These settings apply only when `--tag=package-2025-01 --java` is specified on the command line.
Please also specify `--azure-libraries-for-java=<path to the root directory of your azure-sdk-for-java clone>`.

``` yaml $(tag) == 'package-2025-01' && $(java) && $(multiapi)
java:
  namespace: com.microsoft.azure.management.datadog.v2025_01_07
  output-folder: $(azure-libraries-for-java-folder)/sdk/datadog/mgmt-v2025_01_07
regenerate-manager: true
generate-interface: true
```

### Tag: package-2024-03 and java

These settings apply only when `--tag=package-2024-03 --java` is specified on the command line.
Please also specify `--azure-libraries-for-java=<path to the root directory of your azure-sdk-for-java clone>`.

``` yaml $(tag) == 'package-2024-03' && $(java) && $(multiapi)
java:
  namespace: com.microsoft.azure.management.datadog.v2024_03_01
  output-folder: $(azure-libraries-for-java-folder)/sdk/datadog/mgmt-v2024-03_01
regenerate-manager: true
generate-interface: true
```

### Tag: package-2023-10 and java

These settings apply only when `--tag=package-2023-10 --java` is specified on the command line.
Please also specify `--azure-libraries-for-java=<path to the root directory of your azure-sdk-for-java clone>`.

``` yaml $(tag) == 'package-2023-10' && $(java) && $(multiapi)
java:
  namespace: com.microsoft.azure.management.datadog.v2023_10_20
  output-folder: $(azure-libraries-for-java-folder)/sdk/datadog/mgmt-v2023_10_20
regenerate-manager: true
generate-interface: true
```

### Tag: package-2023-07 and java

These settings apply only when `--tag=package-2023-07 --java` is specified on the command line.
Please also specify `--azure-libraries-for-java=<path to the root directory of your azure-sdk-for-java clone>`.

``` yaml $(tag) == 'package-2023-07' && $(java) && $(multiapi)
java:
  namespace: com.microsoft.azure.management.datadog.v2023_07_07
  output-folder: $(azure-libraries-for-java-folder)/sdk/datadog/mgmt-v2023_07_07
regenerate-manager: true
generate-interface: true
```

### Tag: package-2023-01 and java

These settings apply only when `--tag=package-2023-01 --java` is specified on the command line.
Please also specify `--azure-libraries-for-java=<path to the root directory of your azure-sdk-for-java clone>`.

``` yaml $(tag) == 'package-2023-01' && $(java) && $(multiapi)
java:
  namespace: com.microsoft.azure.management.datadog.v2023_01_01
  output-folder: $(azure-libraries-for-java-folder)/sdk/datadog/mgmt-v2023_01_01
regenerate-manager: true
generate-interface: true
```

### Tag: package-2022-08 and java

These settings apply only when `--tag=package-2022-08 --java` is specified on the command line.
Please also specify `--azure-libraries-for-java=<path to the root directory of your azure-sdk-for-java clone>`.

``` yaml $(tag) == 'package-2022-08' && $(java) && $(multiapi)
java:
  namespace: com.microsoft.azure.management.datadog.v2022_08_01
  output-folder: $(azure-libraries-for-java-folder)/sdk/datadog/mgmt-v2022_08_01
regenerate-manager: true
generate-interface: true
```

### Tag: package-2022-06 and java

These settings apply only when `--tag=package-2022-06 --java` is specified on the command line.
Please also specify `--azure-libraries-for-java=<path to the root directory of your azure-sdk-for-java clone>`.

``` yaml $(tag) == 'package-2022-06' && $(java) && $(multiapi)
java:
  namespace: com.microsoft.azure.management.datadog.v2022_06_01
  output-folder: $(azure-libraries-for-java-folder)/sdk/datadog/mgmt-v2022_06_01
regenerate-manager: true
generate-interface: true
```

### Tag: package-2021-03 and java

These settings apply only when `--tag=package-2021-03 --java` is specified on the command line.
Please also specify `--azure-libraries-for-java=<path to the root directory of your azure-sdk-for-java clone>`.

``` yaml $(tag) == 'package-2021-03' && $(java) && $(multiapi)
java:
  namespace: com.microsoft.azure.management.datadog.v2021_03_01
  output-folder: $(azure-libraries-for-java-folder)/sdk/datadog/mgmt-v2021_03_01
regenerate-manager: true
generate-interface: true
```

### Tag: package-2020-02-preview and java

These settings apply only when `--tag=package-2020-02-preview --java` is specified on the command line.
Please also specify `--azure-libraries-for-java=<path to the root directory of your azure-sdk-for-java clone>`.

``` yaml $(tag) == 'package-2020-02-preview' && $(java) && $(multiapi)
java:
  namespace: com.microsoft.azure.management.datadog.v2020_02_01_preview
  output-folder: $(azure-libraries-for-java-folder)/sdk/datadog/mgmt-v2020_02_01_preview
regenerate-manager: true
generate-interface: true
```
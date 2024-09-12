## Java

These settings apply only when `--java` is specified on the command line and `--tag=profile-hybrid-2020-09-01` is not specified.
Please also specify `--azure-libraries-for-java-folder=<path to the root directory of your azure-libraries-for-java clone>`.

``` yaml $(java)
azure-arm: true
fluent: true
namespace: com.microsoft.azure.management.containerservice
license-header: MICROSOFT_MIT_NO_CODEGEN
payload-flattening-threshold: 1
output-folder: $(azure-libraries-for-java-folder)/azure-mgmt-containerservice
title: ContainerServiceManagementClient
description: "Container Service Client"
directive:
  from: managedClusters.json
  where: "$.definitions.TrustedAccessRoleRule.properties.nonResourceURLs"
  transform: >
    $["x-ms-client-name"] = "nonResourceUrls";
```

These settings also apply when `--tag=profile-hybrid-2020-09-01` is not specified.

``` yaml $(java) && $(tag) != 'profile-hybrid-2020-09-01'
input-file:
  - stable/2019-04-30/openShiftManagedClusters.json
  - stable/2019-08-01/location.json
```

### Java multi-api

``` yaml $(java) && $(multiapi)
batch:
  - tag: package-2019-06
  - tag: package-2019-08
  - tag: package-2019-10
  - tag: package-2019-11
  - tag: package-2020-01
  - tag: package-2020-02
  - tag: package-2020-03
  - tag: package-2020-04
  - tag: package-2020-06
  - tag: package-2020-07
  - tag: package-2020-09
  - tag: package-2020-11
  - tag: package-2020-12
  - tag: package-2021-02
  - tag: package-2021-03
  - tag: package-2021-05
  - tag: package-2021-07
  - tag: package-2021-08
  - tag: package-2021-09
  - tag: package-2021-10
  - tag: package-preview-2022-01
  - tag: package-2022-01
  - tag: package-preview-2022-02
  - tag: package-2022-02
  - tag: package-preview-2022-03
  - tag: package-2022-03
  - tag: package-preview-2022-04
  - tag: package-2022-04
  - tag: package-preview-2022-05
  - tag: package-preview-2022-06
  - tag: package-2022-06
  - tag: package-preview-2022-07
  - tag: package-2022-07
  - tag: package-preview-2022-08
  - tag: package-preview-2022-08-03
  - tag: package-preview-2022-09
  - tag: package-2022-09
  - tag: package-preview-2022-10
  - tag: package-preview-2022-11
  - tag: package-2022-11
  - tag: package-preview-2023-01
  - tag: package-2023-01
  - tag: package-preview-2023-02
  - tag: package-2023-02
  - tag: package-preview-2023-03
  - tag: package-2023-03
  - tag: package-preview-2023-04
  - tag: package-2023-04
  - tag: package-preview-2023-05
  - tag: package-2023-05
  - tag: package-preview-2023-06
  - tag: package-2023-06
  - tag: package-preview-2023-07
  - tag: package-2023-07
  - tag: package-preview-2023-08
  - tag: package-2023-08
  - tag: package-preview-2023-09
  - tag: package-2023-09
  - tag: package-preview-2023-10
  - tag: package-2023-10
  - tag: package-preview-2023-11
  - tag: package-2023-11
  - tag: package-preview-2024-01
  - tag: package-2024-01
  - tag: package-preview-2024-02
  - tag: package-2024-02
  - tag: package-preview-2024-03
  - tag: package-preview-2024-04
  - tag: package-preview-2024-05
  - tag: package-2024-05
  - tag: package-preview-2024-06
  - tag: package-2024-07
```

### Tag: package-2024-07 and java

These settings apply only when `--tag=package-2024-07` is specified on the command line.
Please also specify `--azure-libraries-for-java-folder=<path to the root directory of your azure-sdk-for-java clone>`.

``` yaml $(tag) == 'package-2024-07' && $(java) && $(multiapi)
java:
  namespace: com.microsoft.azure.management.containerservice.v2024_07_01
  output-folder: $(azure-libraries-for-java-folder)/sdk/containerservice/mgmt-v2024_07_01
regenerate-manager: true
generate-interface: true
```

### Tag: package-preview-2024-06 and java

These settings apply only when `--tag=package-preview-2024-06` is specified on the command line.
Please also specify `--azure-libraries-for-java-folder=<path to the root directory of your azure-sdk-for-java clone>`.

``` yaml $(tag) == 'package-preview-2024-06' && $(java) && $(multiapi)
java:
  namespace: com.microsoft.azure.management.containerservice.v2024_06_02_preview
  output-folder: $(azure-libraries-for-java-folder)/sdk/containerservice/mgmt-v2024_06_02_preview
regenerate-manager: true
generate-interface: true
```

### Tag: package-2024-05 and java

These settings apply only when `--tag=package-2024-05` is specified on the command line.
Please also specify `--azure-libraries-for-java-folder=<path to the root directory of your azure-sdk-for-java clone>`.

``` yaml $(tag) == 'package-2024-05' && $(java) && $(multiapi)
java:
  namespace: com.microsoft.azure.management.containerservice.v2024_05_01
  output-folder: $(azure-libraries-for-java-folder)/sdk/containerservice/mgmt-v2024_05_01
regenerate-manager: true
generate-interface: true
```

### Tag: package-preview-2024-05 and java

These settings apply only when `--tag=package-preview-2024-05` is specified on the command line.
Please also specify `--azure-libraries-for-java-folder=<path to the root directory of your azure-sdk-for-java clone>`.

``` yaml $(tag) == 'package-preview-2024-05' && $(java) && $(multiapi)
java:
  namespace: com.microsoft.azure.management.containerservice.v2024_05_02_preview
  output-folder: $(azure-libraries-for-java-folder)/sdk/containerservice/mgmt-v2024_05_02_preview
regenerate-manager: true
generate-interface: true
```

### Tag: package-preview-2024-04 and java

These settings apply only when `--tag=package-preview-2024-04` is specified on the command line.
Please also specify `--azure-libraries-for-java-folder=<path to the root directory of your azure-sdk-for-java clone>`.

``` yaml $(tag) == 'package-preview-2024-04' && $(java) && $(multiapi)
java:
  namespace: com.microsoft.azure.management.containerservice.v2024_04_02_preview
  output-folder: $(azure-libraries-for-java-folder)/sdk/containerservice/mgmt-v2024_04_02_preview
regenerate-manager: true
generate-interface: true
```

### Tag: package-preview-2024-03 and java

These settings apply only when `--tag=package-preview-2024-03` is specified on the command line.
Please also specify `--azure-libraries-for-java-folder=<path to the root directory of your azure-sdk-for-java clone>`.

``` yaml $(tag) == 'package-preview-2024-03' && $(java) && $(multiapi)
java:
  namespace: com.microsoft.azure.management.containerservice.v2024_03_02_preview
  output-folder: $(azure-libraries-for-java-folder)/sdk/containerservice/mgmt-v2024_03_02_preview
regenerate-manager: true
generate-interface: true
```

### Tag: package-2024-02 and java

These settings apply only when `--tag=package-2024-02` is specified on the command line.
Please also specify `--azure-libraries-for-java-folder=<path to the root directory of your azure-sdk-for-java clone>`.

``` yaml $(tag) == 'package-2024-02' && $(java) && $(multiapi)
java:
  namespace: com.microsoft.azure.management.containerservice.v2024_02_01
  output-folder: $(azure-libraries-for-java-folder)/sdk/containerservice/mgmt-v2024_02_01
regenerate-manager: true
generate-interface: true
```

### Tag: package-preview-2024-02 and java

These settings apply only when `--tag=package-preview-2024-02` is specified on the command line.
Please also specify `--azure-libraries-for-java-folder=<path to the root directory of your azure-sdk-for-java clone>`.

``` yaml $(tag) == 'package-preview-2024-02' && $(java) && $(multiapi)
java:
  namespace: com.microsoft.azure.management.containerservice.v2024_02_02_preview
  output-folder: $(azure-libraries-for-java-folder)/sdk/containerservice/mgmt-v2024_02_02_preview
regenerate-manager: true
generate-interface: true
```

### Tag: package-2024-01 and java

These settings apply only when `--tag=package-2024-01` is specified on the command line.
Please also specify `--azure-libraries-for-java-folder=<path to the root directory of your azure-sdk-for-java clone>`.

``` yaml $(tag) == 'package-2024-01' && $(java) && $(multiapi)
java:
  namespace: com.microsoft.azure.management.containerservice.v2024_01_01
  output-folder: $(azure-libraries-for-java-folder)/sdk/containerservice/mgmt-v2024_01_01
regenerate-manager: true
generate-interface: true
```

### Tag: package-preview-2024-01 and java

These settings apply only when `--tag=package-preview-2024-01` is specified on the command line.
Please also specify `--azure-libraries-for-java-folder=<path to the root directory of your azure-sdk-for-java clone>`.

``` yaml $(tag) == 'package-preview-2024-01' && $(java) && $(multiapi)
java:
  namespace: com.microsoft.azure.management.containerservice.v2024_01_02_preview
  output-folder: $(azure-libraries-for-java-folder)/sdk/containerservice/mgmt-v2024_01_02_preview
regenerate-manager: true
generate-interface: true
```

### Tag: package-2023-11 and java

These settings apply only when `--tag=package-2023-11` is specified on the command line.
Please also specify `--azure-libraries-for-java-folder=<path to the root directory of your azure-sdk-for-java clone>`.

``` yaml $(tag) == 'package-2023-11' && $(java) && $(multiapi)
java:
  namespace: com.microsoft.azure.management.containerservice.v2023_11_01
  output-folder: $(azure-libraries-for-java-folder)/sdk/containerservice/mgmt-v2023_11_01
regenerate-manager: true
generate-interface: true
```

### Tag: package-preview-2023-11 and java

These settings apply only when `--tag=package-preview-2023-11` is specified on the command line.
Please also specify `--azure-libraries-for-java-folder=<path to the root directory of your azure-sdk-for-java clone>`.

``` yaml $(tag) == 'package-preview-2023-11' && $(java) && $(multiapi)
java:
  namespace: com.microsoft.azure.management.containerservice.v2023_11_02_preview
  output-folder: $(azure-libraries-for-java-folder)/sdk/containerservice/mgmt-v2023_11_02_preview
regenerate-manager: true
generate-interface: true
```

### Tag: package-2023-10 and java

These settings apply only when `--tag=package-2023-10` is specified on the command line.
Please also specify `--azure-libraries-for-java-folder=<path to the root directory of your azure-sdk-for-java clone>`.

``` yaml $(tag) == 'package-2023-10' && $(java) && $(multiapi)
java:
  namespace: com.microsoft.azure.management.containerservice.v2023_10_01
  output-folder: $(azure-libraries-for-java-folder)/sdk/containerservice/mgmt-v2023_10_01
regenerate-manager: true
generate-interface: true
```

### Tag: package-preview-2023-10 and java

These settings apply only when `--tag=package-preview-2023-10` is specified on the command line.
Please also specify `--azure-libraries-for-java-folder=<path to the root directory of your azure-sdk-for-java clone>`.

``` yaml $(tag) == 'package-preview-2023-10' && $(java) && $(multiapi)
java:
  namespace: com.microsoft.azure.management.containerservice.v2023_10_02_preview
  output-folder: $(azure-libraries-for-java-folder)/sdk/containerservice/mgmt-v2023_10_02_preview
regenerate-manager: true
generate-interface: true
```

### Tag: package-2023-09 and java

These settings apply only when `--tag=package-2023-09` is specified on the command line.
Please also specify `--azure-libraries-for-java-folder=<path to the root directory of your azure-sdk-for-java clone>`.

``` yaml $(tag) == 'package-2023-09' && $(java) && $(multiapi)
java:
  namespace: com.microsoft.azure.management.containerservice.v2023_09_01
  output-folder: $(azure-libraries-for-java-folder)/sdk/containerservice/mgmt-v2023_09_01
regenerate-manager: true
generate-interface: true
```

### Tag: package-preview-2023-09 and java

These settings apply only when `--tag=package-preview-2023-09` is specified on the command line.
Please also specify `--azure-libraries-for-java-folder=<path to the root directory of your azure-sdk-for-java clone>`.

``` yaml $(tag) == 'package-preview-2023-09' && $(java) && $(multiapi)
java:
  namespace: com.microsoft.azure.management.containerservice.v2023_09_02_preview
  output-folder: $(azure-libraries-for-java-folder)/sdk/containerservice/mgmt-v2023_09_02_preview
regenerate-manager: true
generate-interface: true
```

### Tag: package-2023-08 and java

These settings apply only when `--tag=package-2023-08` is specified on the command line.
Please also specify `--azure-libraries-for-java-folder=<path to the root directory of your azure-sdk-for-java clone>`.

``` yaml $(tag) == 'package-2023-08' && $(java) && $(multiapi)
java:
  namespace: com.microsoft.azure.management.containerservice.v2023_08_01
  output-folder: $(azure-libraries-for-java-folder)/sdk/containerservice/mgmt-v2023_08_01
regenerate-manager: true
generate-interface: true
```

### Tag: package-preview-2023-08 and java

These settings apply only when `--tag=package-preview-2023-08` is specified on the command line.
Please also specify `--azure-libraries-for-java-folder=<path to the root directory of your azure-sdk-for-java clone>`.

``` yaml $(tag) == 'package-preview-2023-08' && $(java) && $(multiapi)
java:
  namespace: com.microsoft.azure.management.containerservice.v2023_08_02_preview
  output-folder: $(azure-libraries-for-java-folder)/sdk/containerservice/mgmt-v2023_08_02_preview
regenerate-manager: true
generate-interface: true
```

### Tag: package-2023-07 and java

These settings apply only when `--tag=package-2023-07` is specified on the command line.
Please also specify `--azure-libraries-for-java-folder=<path to the root directory of your azure-sdk-for-java clone>`.

``` yaml $(tag) == 'package-2023-07' && $(java) && $(multiapi)
java:
  namespace: com.microsoft.azure.management.containerservice.v2023_07_01
  output-folder: $(azure-libraries-for-java-folder)/sdk/containerservice/mgmt-v2023_07_01
regenerate-manager: true
generate-interface: true
```

### Tag: package-preview-2023-07 and java

These settings apply only when `--tag=package-preview-2023-07` is specified on the command line.
Please also specify `--azure-libraries-for-java-folder=<path to the root directory of your azure-sdk-for-java clone>`.

``` yaml $(tag) == 'package-preview-2023-07' && $(java) && $(multiapi)
java:
  namespace: com.microsoft.azure.management.containerservice.v2023_07_02_preview
  output-folder: $(azure-libraries-for-java-folder)/sdk/containerservice/mgmt-v2023_07_02_preview
regenerate-manager: true
generate-interface: true
```

### Tag: package-2023-06 and java

These settings apply only when `--tag=package-2023-06` is specified on the command line.
Please also specify `--azure-libraries-for-java-folder=<path to the root directory of your azure-sdk-for-java clone>`.

``` yaml $(tag) == 'package-2023-06' && $(java) && $(multiapi)
java:
  namespace: com.microsoft.azure.management.containerservice.v2023_06_01
  output-folder: $(azure-libraries-for-java-folder)/sdk/containerservice/mgmt-v2023_06_01
regenerate-manager: true
generate-interface: true
```

### Tag: package-preview-2023-06 and java

These settings apply only when `--tag=package-preview-2023-06` is specified on the command line.
Please also specify `--azure-libraries-for-java-folder=<path to the root directory of your azure-sdk-for-java clone>`.

``` yaml $(tag) == 'package-preview-2023-06' && $(java) && $(multiapi)
java:
  namespace: com.microsoft.azure.management.containerservice.v2023_06_02_preview
  output-folder: $(azure-libraries-for-java-folder)/sdk/containerservice/mgmt-v2023_06_02_preview
regenerate-manager: true
generate-interface: true
```

### Tag: package-2023-05 and java

These settings apply only when `--tag=package-2023-05` is specified on the command line.
Please also specify `--azure-libraries-for-java-folder=<path to the root directory of your azure-sdk-for-java clone>`.

``` yaml $(tag) == 'package-2023-05' && $(java) && $(multiapi)
java:
  namespace: com.microsoft.azure.management.containerservice.v2023_05_01
  output-folder: $(azure-libraries-for-java-folder)/sdk/containerservice/mgmt-v2023_05_01
regenerate-manager: true
generate-interface: true
```

### Tag: package-preview-2023-05 and java

These settings apply only when `--tag=package-preview-2023-05` is specified on the command line.
Please also specify `--azure-libraries-for-java-folder=<path to the root directory of your azure-sdk-for-java clone>`.

``` yaml $(tag) == 'package-preview-2023-05' && $(java) && $(multiapi)
java:
  namespace: com.microsoft.azure.management.containerservice.v2023_05_02_preview
  output-folder: $(azure-libraries-for-java-folder)/sdk/containerservice/mgmt-v2023_05_02_preview
regenerate-manager: true
generate-interface: true
```

### Tag: package-2023-04 and java

These settings apply only when `--tag=package-2023-04` is specified on the command line.
Please also specify `--azure-libraries-for-java-folder=<path to the root directory of your azure-sdk-for-java clone>`.

``` yaml $(tag) == 'package-2023-04' && $(java) && $(multiapi)
java:
  namespace: com.microsoft.azure.management.containerservice.v2023_04_01
  output-folder: $(azure-libraries-for-java-folder)/sdk/containerservice/mgmt-v2023_04_01
regenerate-manager: true
generate-interface: true
```

### Tag: package-preview-2023-04 and java

These settings apply only when `--tag=package-preview-2023-04` is specified on the command line.
Please also specify `--azure-libraries-for-java-folder=<path to the root directory of your azure-sdk-for-java clone>`.

``` yaml $(tag) == 'package-preview-2023-04' && $(java) && $(multiapi)
java:
  namespace: com.microsoft.azure.management.containerservice.v2023_04_02_preview
  output-folder: $(azure-libraries-for-java-folder)/sdk/containerservice/mgmt-v2023_04_02_preview
regenerate-manager: true
generate-interface: true
```

### Tag: package-2023-03 and java

These settings apply only when `--tag=package-2023-03` is specified on the command line.
Please also specify `--azure-libraries-for-java-folder=<path to the root directory of your azure-sdk-for-java clone>`.

``` yaml $(tag) == 'package-2023-03' && $(java) && $(multiapi)
java:
  namespace: com.microsoft.azure.management.containerservice.v2023_03_01
  output-folder: $(azure-libraries-for-java-folder)/sdk/containerservice/mgmt-v2023_03_01
regenerate-manager: true
generate-interface: true
```

### Tag: package-preview-2023-03 and java

These settings apply only when `--tag=package-preview-2023-03` is specified on the command line.
Please also specify `--azure-libraries-for-java-folder=<path to the root directory of your azure-sdk-for-java clone>`.

``` yaml $(tag) == 'package-preview-2023-03' && $(java) && $(multiapi)
java:
  namespace: com.microsoft.azure.management.containerservice.v2023_03_02_preview
  output-folder: $(azure-libraries-for-java-folder)/sdk/containerservice/mgmt-v2023_03_02_preview
regenerate-manager: true
generate-interface: true
```

### Tag: package-2023-02 and java

These settings apply only when `--tag=package-2023-02` is specified on the command line.
Please also specify `--azure-libraries-for-java-folder=<path to the root directory of your azure-sdk-for-java clone>`.

``` yaml $(tag) == 'package-2023-02' && $(java) && $(multiapi)
java:
  namespace: com.microsoft.azure.management.containerservice.v2023_02_01
  output-folder: $(azure-libraries-for-java-folder)/sdk/containerservice/mgmt-v2023_02_01
regenerate-manager: true
generate-interface: true
```

### Tag: package-preview-2023-02 and java

These settings apply only when `--tag=package-preview-2023-02` is specified on the command line.
Please also specify `--azure-libraries-for-java-folder=<path to the root directory of your azure-sdk-for-java clone>`.

``` yaml $(tag) == 'package-preview-2023-02' && $(java) && $(multiapi)
java:
  namespace: com.microsoft.azure.management.containerservice.v2023_02_02_preview
  output-folder: $(azure-libraries-for-java-folder)/sdk/containerservice/mgmt-v2023_02_02_preview
regenerate-manager: true
generate-interface: true
```

### Tag: package-2023-01 and java

These settings apply only when `--tag=package-2023-01` is specified on the command line.
Please also specify `--azure-libraries-for-java-folder=<path to the root directory of your azure-sdk-for-java clone>`.

``` yaml $(tag) == 'package-2023-01' && $(java) && $(multiapi)
java:
  namespace: com.microsoft.azure.management.containerservice.v2023_01_01
  output-folder: $(azure-libraries-for-java-folder)/sdk/containerservice/mgmt-v2023_01_01
regenerate-manager: true
generate-interface: true
```

### Tag: package-preview-2023-01 and java

These settings apply only when `--tag=package-preview-2023-01` is specified on the command line.
Please also specify `--azure-libraries-for-java-folder=<path to the root directory of your azure-sdk-for-java clone>`.

``` yaml $(tag) == 'package-preview-2023-01' && $(java) && $(multiapi)
java:
  namespace: com.microsoft.azure.management.containerservice.v2023_01_02_preview
  output-folder: $(azure-libraries-for-java-folder)/sdk/containerservice/mgmt-v2023_01_02_preview
regenerate-manager: true
generate-interface: true
```

### Tag: package-2022-11 and java

These settings apply only when `--tag=package-2022-11` is specified on the command line.
Please also specify `--azure-libraries-for-java-folder=<path to the root directory of your azure-sdk-for-java clone>`.

``` yaml $(tag) == 'package-2022-11' && $(java) && $(multiapi)
java:
  namespace: com.microsoft.azure.management.containerservice.v2022_11_01
  output-folder: $(azure-libraries-for-java-folder)/sdk/containerservice/mgmt-v2022_11_01
regenerate-manager: true
generate-interface: true
```

### Tag: package-preview-2022-11 and java

These settings apply only when `--tag=package-preview-2022-11` is specified on the command line.
Please also specify `--azure-libraries-for-java-folder=<path to the root directory of your azure-sdk-for-java clone>`.

``` yaml $(tag) == 'package-preview-2022-11' && $(java) && $(multiapi)
java:
  namespace: com.microsoft.azure.management.containerservice.v2022_11_02_preview
  output-folder: $(azure-libraries-for-java-folder)/sdk/containerservice/mgmt-v2022_11_02_preview
regenerate-manager: true
generate-interface: true
```

### Tag: package-preview-2022-10 and java

These settings apply only when `--tag=package-preview-2022-10` is specified on the command line.
Please also specify `--azure-libraries-for-java-folder=<path to the root directory of your azure-sdk-for-java clone>`.

``` yaml $(tag) == 'package-preview-2022-10' && $(java) && $(multiapi)
java:
  namespace: com.microsoft.azure.management.containerservice.v2022_10_02_preview
  output-folder: $(azure-libraries-for-java-folder)/sdk/containerservice/mgmt-v2022_10_02_preview
regenerate-manager: true
generate-interface: true
```

### Tag: package-2022-09 and java

These settings apply only when `--tag=package-2022-09` is specified on the command line.
Please also specify `--azure-libraries-for-java-folder=<path to the root directory of your azure-sdk-for-java clone>`.

``` yaml $(tag) == 'package-2022-09' && $(java) && $(multiapi)
java:
  namespace: com.microsoft.azure.management.containerservice.v2022_09_01
  output-folder: $(azure-libraries-for-java-folder)/sdk/containerservice/mgmt-v2022_09_01
regenerate-manager: true
generate-interface: true
```

### Tag: package-preview-2022-09 and java

These settings apply only when `--tag=package-preview-2022-09` is specified on the command line.
Please also specify `--azure-libraries-for-java-folder=<path to the root directory of your azure-sdk-for-java clone>`.

``` yaml $(tag) == 'package-preview-2022-09' && $(java) && $(multiapi)
java:
  namespace: com.microsoft.azure.management.containerservice.v2022_09_02_preview
  output-folder: $(azure-libraries-for-java-folder)/sdk/containerservice/mgmt-v2022_09_02_preview
regenerate-manager: true
generate-interface: true
```

### Tag: package-preview-2022-08-03 and java

These settings apply only when `--tag=package-preview-2022-08-03` is specified on the command line.
Please also specify `--azure-libraries-for-java-folder=<path to the root directory of your azure-sdk-for-java clone>`.

``` yaml $(tag) == 'package-preview-2022-08-03' && $(java) && $(multiapi)
java:
  namespace: com.microsoft.azure.management.containerservice.v2022_08_03_preview
  output-folder: $(azure-libraries-for-java-folder)/sdk/containerservice/mgmt-v2022_08_03_preview
regenerate-manager: true
generate-interface: true
```

### Tag: package-preview-2022-08 and java

These settings apply only when `--tag=package-preview-2022-08` is specified on the command line.
Please also specify `--azure-libraries-for-java-folder=<path to the root directory of your azure-sdk-for-java clone>`.

``` yaml $(tag) == 'package-preview-2022-08' && $(java) && $(multiapi)
java:
  namespace: com.microsoft.azure.management.containerservice.v2022_08_02_preview
  output-folder: $(azure-libraries-for-java-folder)/sdk/containerservice/mgmt-v2022_08_02_preview
regenerate-manager: true
generate-interface: true
```

### Tag: package-2022-07 and java

These settings apply only when `--tag=package-2022-07` is specified on the command line.
Please also specify `--azure-libraries-for-java-folder=<path to the root directory of your azure-sdk-for-java clone>`.

``` yaml $(tag) == 'package-2022-07' && $(java) && $(multiapi)
java:
  namespace: com.microsoft.azure.management.containerservice.v2022_07_01
  output-folder: $(azure-libraries-for-java-folder)/sdk/containerservice/mgmt-v2022_07_01
regenerate-manager: true
generate-interface: true
```

### Tag: package-preview-2022-07 and java

These settings apply only when `--tag=package-preview-2022-07` is specified on the command line.
Please also specify `--azure-libraries-for-java-folder=<path to the root directory of your azure-sdk-for-java clone>`.

``` yaml $(tag) == 'package-preview-2022-07' && $(java) && $(multiapi)
java:
  namespace: com.microsoft.azure.management.containerservice.v2022_07_02_preview
  output-folder: $(azure-libraries-for-java-folder)/sdk/containerservice/mgmt-v2022_07_02_preview
regenerate-manager: true
generate-interface: true
```

### Tag: package-2022-06 and java

These settings apply only when `--tag=package-2022-06` is specified on the command line.
Please also specify `--azure-libraries-for-java-folder=<path to the root directory of your azure-sdk-for-java clone>`.

``` yaml $(tag) == 'package-2022-06' && $(java) && $(multiapi)
java:
  namespace: com.microsoft.azure.management.containerservice.v2022_06_01
  output-folder: $(azure-libraries-for-java-folder)/sdk/containerservice/mgmt-v2022_06_01
regenerate-manager: true
generate-interface: true
```

### Tag: package-preview-2022-06 and java

These settings apply only when `--tag=package-preview-2022-06` is specified on the command line.
Please also specify `--azure-libraries-for-java-folder=<path to the root directory of your azure-sdk-for-java clone>`.

``` yaml $(tag) == 'package-preview-2022-06' && $(java) && $(multiapi)
java:
  namespace: com.microsoft.azure.management.containerservice.v2022_06_02_preview
  output-folder: $(azure-libraries-for-java-folder)/sdk/containerservice/mgmt-v2022_06_02_preview
regenerate-manager: true
generate-interface: true
```

### Tag: package-preview-2022-05 and java

These settings apply only when `--tag=package-preview-2022-05` is specified on the command line.
Please also specify `--azure-libraries-for-java-folder=<path to the root directory of your azure-sdk-for-java clone>`.

``` yaml $(tag) == 'package-preview-2022-05' && $(java) && $(multiapi)
java:
  namespace: com.microsoft.azure.management.containerservice.v2022_05_02_preview
  output-folder: $(azure-libraries-for-java-folder)/sdk/containerservice/mgmt-v2022_05_02_preview
regenerate-manager: true
generate-interface: true
```

### Tag: package-2022-04 and java

These settings apply only when `--tag=package-2022-04` is specified on the command line.
Please also specify `--azure-libraries-for-java-folder=<path to the root directory of your azure-sdk-for-java clone>`.

``` yaml $(tag) == 'package-2022-04' && $(java) && $(multiapi)
java:
  namespace: com.microsoft.azure.management.containerservice.v2022_04_01
  output-folder: $(azure-libraries-for-java-folder)/sdk/containerservice/mgmt-v2022_04_01
regenerate-manager: true
generate-interface: true
```

### Tag: package-preview-2022-04 and java

These settings apply only when `--tag=package-preview-2022-04` is specified on the command line.
Please also specify `--azure-libraries-for-java-folder=<path to the root directory of your azure-sdk-for-java clone>`.

``` yaml $(tag) == 'package-preview-2022-04' && $(java) && $(multiapi)
java:
  namespace: com.microsoft.azure.management.containerservice.v2022_04_02_preview
  output-folder: $(azure-libraries-for-java-folder)/sdk/containerservice/mgmt-v2022_04_02_preview
regenerate-manager: true
generate-interface: true
```

### Tag: package-2022-03 and java

These settings apply only when `--tag=package-2022-03` is specified on the command line.
Please also specify `--azure-libraries-for-java-folder=<path to the root directory of your azure-sdk-for-java clone>`.

``` yaml $(tag) == 'package-2022-03' && $(java) && $(multiapi)
java:
  namespace: com.microsoft.azure.management.containerservice.v2022_03_01
  output-folder: $(azure-libraries-for-java-folder)/sdk/containerservice/mgmt-v2022_03_01
regenerate-manager: true
generate-interface: true
```

### Tag: package-preview-2022-03 and java

These settings apply only when `--tag=package-preview-2022-03` is specified on the command line.
Please also specify `--azure-libraries-for-java-folder=<path to the root directory of your azure-sdk-for-java clone>`.

``` yaml $(tag) == 'package-preview-2022-03' && $(java) && $(multiapi)
java:
  namespace: com.microsoft.azure.management.containerservice.v2022_03_02_preview
  output-folder: $(azure-libraries-for-java-folder)/sdk/containerservice/mgmt-v2022_03_02_preview
regenerate-manager: true
generate-interface: true
```

### Tag: package-2022-02 and java

These settings apply only when `--tag=package-2022-02` is specified on the command line.
Please also specify `--azure-libraries-for-java-folder=<path to the root directory of your azure-sdk-for-java clone>`.

``` yaml $(tag) == 'package-2022-02' && $(java) && $(multiapi)
java:
  namespace: com.microsoft.azure.management.containerservice.v2022_02_01
  output-folder: $(azure-libraries-for-java-folder)/sdk/containerservice/mgmt-v2022_02_01
regenerate-manager: true
generate-interface: true
```

### Tag: package-preview-2022-02 and java

These settings apply only when `--tag=package-preview-2022-02` is specified on the command line.
Please also specify `--azure-libraries-for-java-folder=<path to the root directory of your azure-sdk-for-java clone>`.

``` yaml $(tag) == 'package-preview-2022-02' && $(java) && $(multiapi)
java:
  namespace: com.microsoft.azure.management.containerservice.v2022_02_02_preview
  output-folder: $(azure-libraries-for-java-folder)/sdk/containerservice/mgmt-v2022_02_02_preview
regenerate-manager: true
generate-interface: true
```

### Tag: package-2022-01 and java

These settings apply only when `--tag=package-2022-01` is specified on the command line.
Please also specify `--azure-libraries-for-java-folder=<path to the root directory of your azure-sdk-for-java clone>`.

``` yaml $(tag) == 'package-2022-01' && $(java) && $(multiapi)
java:
  namespace: com.microsoft.azure.management.containerservice.v2022_01_01
  output-folder: $(azure-libraries-for-java-folder)/sdk/containerservice/mgmt-v2022_01_01
regenerate-manager: true
generate-interface: true
```

### Tag: package-preview-2022-01 and java

These settings apply only when `--tag=package-preview-2022-01` is specified on the command line.
Please also specify `--azure-libraries-for-java-folder=<path to the root directory of your azure-sdk-for-java clone>`.

``` yaml $(tag) == 'package-preview-2022-01' && $(java) && $(multiapi)
java:
  namespace: com.microsoft.azure.management.containerservice.v2022_01_02_preview
  output-folder: $(azure-libraries-for-java-folder)/sdk/containerservice/mgmt-v2022_01_02_preview
regenerate-manager: true
generate-interface: true
```

### Tag: package-2021-10 and java

These settings apply only when `--tag=package-2021-10` is specified on the command line.
Please also specify `--azure-libraries-for-java-folder=<path to the root directory of your azure-sdk-for-java clone>`.

``` yaml $(tag) == 'package-2021-10' && $(java) && $(multiapi)
java:
  namespace: com.microsoft.azure.management.containerservice.v2021_10_01
  output-folder: $(azure-libraries-for-java-folder)/sdk/containerservice/mgmt-v2021_10_01
regenerate-manager: true
generate-interface: true
```

### Tag: package-2021-09 and java

These settings apply only when `--tag=package-2021-09` is specified on the command line.
Please also specify `--azure-libraries-for-java-folder=<path to the root directory of your azure-sdk-for-java clone>`.

``` yaml $(tag) == 'package-2021-09' && $(java) && $(multiapi)
java:
  namespace: com.microsoft.azure.management.containerservice.v2021_09_01
  output-folder: $(azure-libraries-for-java-folder)/sdk/containerservice/mgmt-v2021_09_01
regenerate-manager: true
generate-interface: true
```

### Tag: package-2021-08 and java

These settings apply only when `--tag=package-2021-08` is specified on the command line.
Please also specify `--azure-libraries-for-java-folder=<path to the root directory of your azure-sdk-for-java clone>`.

``` yaml $(tag) == 'package-2021-08' && $(java) && $(multiapi)
java:
  namespace: com.microsoft.azure.management.containerservice.v2021_08_01
  output-folder: $(azure-libraries-for-java-folder)/sdk/containerservice/mgmt-v2021_08_01
regenerate-manager: true
generate-interface: true
```

### Tag: package-2021-07 and java

These settings apply only when `--tag=package-2021-07` is specified on the command line.
Please also specify `--azure-libraries-for-java-folder=<path to the root directory of your azure-sdk-for-java clone>`.

``` yaml $(tag) == 'package-2021-07' && $(java) && $(multiapi)
java:
  namespace: com.microsoft.azure.management.containerservice.v2021_07_01
  output-folder: $(azure-libraries-for-java-folder)/sdk/containerservice/mgmt-v2021_07_01
regenerate-manager: true
generate-interface: true
```

### Tag: package-2021-05 and java

These settings apply only when `--tag=package-2021-05` is specified on the command line.
Please also specify `--azure-libraries-for-java-folder=<path to the root directory of your azure-sdk-for-java clone>`.

``` yaml $(tag) == 'package-2021-05' && $(java) && $(multiapi)
java:
  namespace: com.microsoft.azure.management.containerservice.v2021_05_01
  output-folder: $(azure-libraries-for-java-folder)/sdk/containerservice/mgmt-v2021_05_01
regenerate-manager: true
generate-interface: true
```

### Tag: package-2021-03 and java

These settings apply only when `--tag=package-2021-03` is specified on the command line.
Please also specify `--azure-libraries-for-java-folder=<path to the root directory of your azure-sdk-for-java clone>`.

``` yaml $(tag) == 'package-2021-03' && $(java) && $(multiapi)
java:
  namespace: com.microsoft.azure.management.containerservice.v2021_03_01
  output-folder: $(azure-libraries-for-java-folder)/sdk/containerservice/mgmt-v2021_03_01
regenerate-manager: true
generate-interface: true
```

### Tag: package-2021-02 and java

These settings apply only when `--tag=package-2021-02` is specified on the command line.
Please also specify `--azure-libraries-for-java-folder=<path to the root directory of your azure-sdk-for-java clone>`.

``` yaml $(tag) == 'package-2021-02' && $(java) && $(multiapi)
java:
  namespace: com.microsoft.azure.management.containerservice.v2021_02_01
  output-folder: $(azure-libraries-for-java-folder)/sdk/containerservice/mgmt-v2021_02_01
regenerate-manager: true
generate-interface: true
```

### Tag: package-2020-12 and java

These settings apply only when `--tag=package-2020-12` is specified on the command line.
Please also specify `--azure-libraries-for-java-folder=<path to the root directory of your azure-sdk-for-java clone>`.

``` yaml $(tag) == 'package-2020-12' && $(java) && $(multiapi)
java:
  namespace: com.microsoft.azure.management.containerservice.v2020_12_01
  output-folder: $(azure-libraries-for-java-folder)/sdk/containerservice/mgmt-v2020_12_01
regenerate-manager: true
generate-interface: true
```

### Tag: package-2020-11 and java

These settings apply only when `--tag=package-2020-11` is specified on the command line.
Please also specify `--azure-libraries-for-java-folder=<path to the root directory of your azure-sdk-for-java clone>`.

``` yaml $(tag) == 'package-2020-11' && $(java) && $(multiapi)
java:
  namespace: com.microsoft.azure.management.containerservice.v2020_11_01
  output-folder: $(azure-libraries-for-java-folder)/sdk/containerservice/mgmt-v2020_11_01
regenerate-manager: true
generate-interface: true
```

### Tag: package-2020-09 and java

These settings apply only when `--tag=package-2020-09` is specified on the command line.
Please also specify `--azure-libraries-for-java-folder=<path to the root directory of your azure-sdk-for-java clone>`.

``` yaml $(tag) == 'package-2020-09' && $(java) && $(multiapi)
java:
  namespace: com.microsoft.azure.management.containerservice.v2020_09_01
  output-folder: $(azure-libraries-for-java-folder)/sdk/containerservice/mgmt-v2020_09_01
regenerate-manager: true
generate-interface: true
```

### Tag: package-2020-07 and java

These settings apply only when `--tag=package-2020-07` is specified on the command line.
Please also specify `--azure-libraries-for-java-folder=<path to the root directory of your azure-sdk-for-java clone>`.

``` yaml $(tag) == 'package-2020-07' && $(java) && $(multiapi)
java:
  namespace: com.microsoft.azure.management.containerservice.v2020_07_01
  output-folder: $(azure-libraries-for-java-folder)/sdk/containerservice/mgmt-v2020_07_01
regenerate-manager: true
generate-interface: true
```

### Tag: package-2020-06 and java

These settings apply only when `--tag=package-2020-06` is specified on the command line.
Please also specify `--azure-libraries-for-java-folder=<path to the root directory of your azure-sdk-for-java clone>`.

``` yaml $(tag) == 'package-2020-06' && $(java) && $(multiapi)
java:
  namespace: com.microsoft.azure.management.containerservice.v2020_06_01
  output-folder: $(azure-libraries-for-java-folder)/sdk/containerservice/mgmt-v2020_06_01
regenerate-manager: true
generate-interface: true
```

### Tag: package-2020-04 and java

These settings apply only when `--tag=package-2020-04` is specified on the command line.
Please also specify `--azure-libraries-for-java-folder=<path to the root directory of your azure-sdk-for-java clone>`.

``` yaml $(tag) == 'package-2020-04' && $(java) && $(multiapi)
java:
  namespace: com.microsoft.azure.management.containerservice.v2020_04_01
  output-folder: $(azure-libraries-for-java-folder)/sdk/containerservice/mgmt-v2020_04_01
regenerate-manager: true
generate-interface: true
```

### Tag: package-2020-03 and java

These settings apply only when `--tag=package-2020-03` is specified on the command line.
Please also specify `--azure-libraries-for-java-folder=<path to the root directory of your azure-sdk-for-java clone>`.

``` yaml $(tag) == 'package-2020-03' && $(java) && $(multiapi)
java:
  namespace: com.microsoft.azure.management.containerservice.v2020_03_01
  output-folder: $(azure-libraries-for-java-folder)/sdk/containerservice/mgmt-v2020_03_01
regenerate-manager: true
generate-interface: true
```

### Tag: package-2020-02 and java

These settings apply only when `--tag=package-2020-02` is specified on the command line.
Please also specify `--azure-libraries-for-java-folder=<path to the root directory of your azure-sdk-for-java clone>`.

``` yaml $(tag) == 'package-2020-02' && $(java) && $(multiapi)
java:
  namespace: com.microsoft.azure.management.containerservice.v2020_02_01
  output-folder: $(azure-libraries-for-java-folder)/sdk/containerservice/mgmt-v2020_02_01
regenerate-manager: true
generate-interface: true
```

### Tag: package-2020-01 and java

These settings apply only when `--tag=package-2020-01` is specified on the command line.
Please also specify `--azure-libraries-for-java-folder=<path to the root directory of your azure-sdk-for-java clone>`.

``` yaml $(tag) == 'package-2020-01' && $(java) && $(multiapi)
java:
  namespace: com.microsoft.azure.management.containerservice.v2020_01_01
  output-folder: $(azure-libraries-for-java-folder)/sdk/containerservice/mgmt-v2020_01_01
regenerate-manager: true
generate-interface: true
```

### Tag: package-2019-11 and java

These settings apply only when `--tag=package-2019-11` is specified on the command line.
Please also specify `--azure-libraries-for-java-folder=<path to the root directory of your azure-sdk-for-java clone>`.

``` yaml $(tag) == 'package-2019-11' && $(java) && $(multiapi)
java:
  namespace: com.microsoft.azure.management.containerservice.v2019_11_01
  output-folder: $(azure-libraries-for-java-folder)/sdk/containerservice/mgmt-v2019_11_01
regenerate-manager: true
generate-interface: true
```

### Tag: package-2019-10 and java

These settings apply only when `--tag=package-2019-10` is specified on the command line.
Please also specify `--azure-libraries-for-java-folder=<path to the root directory of your azure-sdk-for-java clone>`.

``` yaml $(tag) == 'package-2019-10' && $(java) && $(multiapi)
java:
  namespace: com.microsoft.azure.management.containerservice.v2019_10_01
  output-folder: $(azure-libraries-for-java-folder)/sdk/containerservice/mgmt-v2019_10_01
regenerate-manager: true
generate-interface: true
```

### Tag: package-2019-08 and java

These settings apply only when `--tag=package-2019-08` is specified on the command line.
Please also specify `--azure-libraries-for-java-folder=<path to the root directory of your azure-sdk-for-java clone>`.

``` yaml $(tag) == 'package-2019-08' && $(java) && $(multiapi)
java:
  namespace: com.microsoft.azure.management.containerservice.v2019_08_01
  output-folder: $(azure-libraries-for-java-folder)/sdk/containerservice/mgmt-v2019_08_01
regenerate-manager: true
generate-interface: true
```

### Tag: package-2019-06 and java

These settings apply only when `--tag=package-2019-06` is specified on the command line.
Please also specify `--azure-libraries-for-java-folder=<path to the root directory of your azure-sdk-for-java clone>`.

``` yaml $(tag) == 'package-2019-06' && $(java) && $(multiapi)
java:
  namespace: com.microsoft.azure.management.containerservice.v2019_06_01
  output-folder: $(azure-libraries-for-java-folder)/sdk/containerservice/mgmt-v2019_06_01
regenerate-manager: true
generate-interface: true
```

### Tag: package-2019-04-only and java

These settings apply only when `--tag=package-2019-04-only` is specified on the command line.
Please also specify `--azure-libraries-for-java-folder=<path to the root directory of your azure-sdk-for-java clone>`.

``` yaml $(tag) == 'package-2019-04-only' && $(java) && $(multiapi)
java:
  namespace: com.microsoft.azure.management.containerservice.v2019_04_01
  output-folder: $(azure-libraries-for-java-folder)/sdk/containerservice/mgmt-v2019_04_01
regenerate-manager: true
generate-interface: true
```

### Tag: package-2017-09-only and java

These settings apply only when `--tag=package-2017-09-only` is specified on the command line.
Please also specify `--azure-libraries-for-java-folder=<path to the root directory of your azure-sdk-for-java clone>`.

``` yaml $(tag) == 'package-2017-09-only' && $(java) && $(multiapi)
java:
  namespace: com.microsoft.azure.management.containerservice.v2017_09_30
  output-folder: $(azure-libraries-for-java-folder)/sdk/containerservice/mgmt-v2017_09_30
regenerate-manager: true
generate-interface: true
```

### Tag: package-2017-08-only and java

These settings apply only when `--tag=package-2017-08-only` is specified on the command line.
Please also specify `--azure-libraries-for-java-folder=<path to the root directory of your azure-sdk-for-java clone>`.

``` yaml $(tag) == 'package-2017-08-only' && $(java) && $(multiapi)
java:
  namespace: com.microsoft.azure.management.containerservice.v2017_08_31
  output-folder: $(azure-libraries-for-java-folder)/sdk/containerservice/mgmt-v2017_08_31
regenerate-manager: true
generate-interface: true
```

### Tag: package-2017-07 and java

These settings apply only when `--tag=package-2017-07` is specified on the command line.
Please also specify `--azure-libraries-for-java-folder=<path to the root directory of your azure-sdk-for-java clone>`.

``` yaml $(tag) == 'package-2017-07' && $(java) && $(multiapi)
java:
  namespace: com.microsoft.azure.management.containerservice.v2017_07_01
  output-folder: $(azure-libraries-for-java-folder)/sdk/containerservice/mgmt-v2017_07_01
regenerate-manager: true
generate-interface: true
```

### Tag: profile-hybrid-2020-09-01 and java

These settings apply only when `--tag=profile-hybrid-2020-09-01 --java` is specified on the command line.
Please also specify `--azure-libraries-for-java-folder=<path to the root directory of your azure-sdk-for-java clone>`.

``` yaml $(tag) == 'profile-hybrid-2020-09-01' && $(java)
input-file:
  - stable/2019-04-30/openShiftManagedClusters.json
```

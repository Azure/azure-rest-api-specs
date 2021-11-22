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
```

These settings also apply when `--tag=profile-hybrid-2020-09-01` is not specified.

``` yaml $(java) && $(tag) != 'profile-hybrid-2020-09-01'
input-file:
  - Microsoft.ContainerService/stable/2019-04-30/openShiftManagedClusters.json
  - Microsoft.ContainerService/stable/2019-08-01/location.json
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
  - Microsoft.ContainerService/stable/2019-04-30/openShiftManagedClusters.json
```

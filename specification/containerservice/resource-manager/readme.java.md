These settings apply only when `--java` is specified on the command line.
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
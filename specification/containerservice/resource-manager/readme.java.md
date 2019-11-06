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
```

### Tag: package-2019-10 and java

These settings apply only when `--tag=package-2019-10` is specified on the command line.
Please also specify `--azure-libraries-for-java-folder=<path to the root directory of your azure-sdk-for-java clone>`.

``` yaml $(tag) == 'package-2019-10' && $(java) && $(multiapi)
java:
  namespace: com.microsoft.azure.management.containerservice.v2019_10_01
  output-folder: $(azure-libraries-for-java-folder)/containerservice/resource-manager/v2019_10_01
regenerate-manager: true
generate-interface: true
```

### Tag: package-2019-08 and java

These settings apply only when `--tag=package-2019-08` is specified on the command line.
Please also specify `--azure-libraries-for-java-folder=<path to the root directory of your azure-sdk-for-java clone>`.

``` yaml $(tag) == 'package-2019-08' && $(java) && $(multiapi)
java:
  namespace: com.microsoft.azure.management.containerservice.v2019_08_01
  output-folder: $(azure-libraries-for-java-folder)/containerservice/resource-manager/v2019_08_01
regenerate-manager: true
generate-interface: true
```

### Tag: package-2019-06 and java

These settings apply only when `--tag=package-2019-06` is specified on the command line.
Please also specify `--azure-libraries-for-java-folder=<path to the root directory of your azure-sdk-for-java clone>`.

``` yaml $(tag) == 'package-2019-06' && $(java) && $(multiapi)
java:
  namespace: com.microsoft.azure.management.containerservice.v2019_06_01
  output-folder: $(azure-libraries-for-java-folder)/containerservice/resource-manager/v2019_06_01
regenerate-manager: true
generate-interface: true
```

### Tag: package-2019-04-only and java

These settings apply only when `--tag=package-2019-04-only` is specified on the command line.
Please also specify `--azure-libraries-for-java-folder=<path to the root directory of your azure-sdk-for-java clone>`.

``` yaml $(tag) == 'package-2019-04-only' && $(java) && $(multiapi)
java:
  namespace: com.microsoft.azure.management.containerservice.v2019_04_01
  output-folder: $(azure-libraries-for-java-folder)/containerservice/resource-manager/v2019_04_01
regenerate-manager: true
generate-interface: true
```

### Tag: package-2017-09-only and java

These settings apply only when `--tag=package-2017-09-only` is specified on the command line.
Please also specify `--azure-libraries-for-java-folder=<path to the root directory of your azure-sdk-for-java clone>`.

``` yaml $(tag) == 'package-2017-09-only' && $(java) && $(multiapi)
java:
  namespace: com.microsoft.azure.management.containerservice.v2017_09_30
  output-folder: $(azure-libraries-for-java-folder)/containerservice/resource-manager/v2017_09_30
regenerate-manager: true
generate-interface: true
```

### Tag: package-2017-08-only and java

These settings apply only when `--tag=package-2017-08-only` is specified on the command line.
Please also specify `--azure-libraries-for-java-folder=<path to the root directory of your azure-sdk-for-java clone>`.

``` yaml $(tag) == 'package-2017-08-only' && $(java) && $(multiapi)
java:
  namespace: com.microsoft.azure.management.containerservice.v2017_08_31
  output-folder: $(azure-libraries-for-java-folder)/containerservice/resource-manager/v2017_08_31
regenerate-manager: true
generate-interface: true
```

### Tag: package-2017-07 and java

These settings apply only when `--tag=package-2017-07` is specified on the command line.
Please also specify `--azure-libraries-for-java-folder=<path to the root directory of your azure-sdk-for-java clone>`.

``` yaml $(tag) == 'package-2017-07' && $(java) && $(multiapi)
java:
  namespace: com.microsoft.azure.management.containerservice.v2017_07_01
  output-folder: $(azure-libraries-for-java-folder)/containerservice/resource-manager/v2017_07_01
regenerate-manager: true
generate-interface: true
```
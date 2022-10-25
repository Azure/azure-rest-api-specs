## Java

These settings apply only when `--java` is specified on the command line.
Please also specify `--azure-libraries-for-java-folder=<path to the root directory of your azure-libraries-for-java clone>`.

``` yaml $(java)
azure-arm: true
fluent: true
namespace: com.microsoft.azure.management.containerservicefleet
license-header: MICROSOFT_MIT_NO_CODEGEN
payload-flattening-threshold: 1
output-folder: $(azure-libraries-for-java-folder)/azure-mgmt-containerservicefleet
title: ContainerServiceFleetManagementClient
description: "Container Service Client"
```

### Java multi-api

``` yaml $(java) && $(multiapi)
batch:
  - tag: package-preview-2022-09
  - tag: package-preview-2022-07
  - tag: package-preview-2022-06  
```

### Tag: package-preview-2022-09 and java

These settings apply only when `--tag=package-preview-2022-09` is specified on the command line.
Please also specify `--azure-libraries-for-java-folder=<path to the root directory of your azure-sdk-for-java clone>`.

``` yaml $(tag) == 'package-preview-2022-09' && $(java) && $(multiapi)
java:
  namespace: com.microsoft.azure.management.containerservicefleet.v2022_09_02_preview
  output-folder: $(azure-libraries-for-java-folder)/sdk/containerservicefleet/mgmt-v2022_09_02_preview
regenerate-manager: true
generate-interface: true
```

### Tag: package-preview-2022-07 and java

These settings apply only when `--tag=package-preview-2022-07` is specified on the command line.
Please also specify `--azure-libraries-for-java-folder=<path to the root directory of your azure-sdk-for-java clone>`.

``` yaml $(tag) == 'package-preview-2022-07' && $(java) && $(multiapi)
java:
  namespace: com.microsoft.azure.management.containerservicefleet.v2022_07_02_preview
  output-folder: $(azure-libraries-for-java-folder)/sdk/containerservicefleet/mgmt-v2022_07_02_preview
regenerate-manager: true
generate-interface: true
```

### Tag: package-preview-2022-06 and java

These settings apply only when `--tag=package-preview-2022-06` is specified on the command line.
Please also specify `--azure-libraries-for-java-folder=<path to the root directory of your azure-sdk-for-java clone>`.

``` yaml $(tag) == 'package-preview-2022-06' && $(java) && $(multiapi)
java:
  namespace: com.microsoft.azure.management.containerservicefleet.v2022_06_02_preview
  output-folder: $(azure-libraries-for-java-folder)/sdk/containerservicefleet/mgmt-v2022_06_02_preview
regenerate-manager: true
generate-interface: true
```

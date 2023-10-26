## Java

These settings apply only when `--java` is specified on the command line and `--tag=profile-hybrid-2020-09-01` is not specified.
Please also specify `--azure-libraries-for-java-folder=<path to the root directory of your azure-libraries-for-java clone>`.

``` yaml $(java)
azure-arm: true
fluent: true
namespace: com.microsoft.azure.management.containerservicefleet
license-header: MICROSOFT_MIT_NO_CODEGEN
payload-flattening-threshold: 1
output-folder: $(azure-libraries-for-java-folder)/azure-mgmt-containerservicefleet
title: ContainerServiceFleetManagementClient
description: "Azure Kubernetes Fleet Manager Client"
```

### Java multi-api

``` yaml $(java) && $(multiapi)
batch:
  - tag: package-2023-08-preview
  - tag: package-2023-06-preview
  - tag: package-2023-03-preview
  - tag: package-2022-09-preview
  - tag: package-2022-07-preview
  - tag: package-2022-06-preview
```

### Tag: package-2023-08-preview and java

These settings apply only when `--tag=package-2023-08-preview` is specified on the command line.
Please also specify `--azure-libraries-for-java-folder=<path to the root directory of your azure-sdk-for-java clone>`.

``` yaml $(tag) == 'package-2023-08-preview' && $(java) && $(multiapi)
java:
  namespace: com.microsoft.azure.management.containerservicefleet.v2023_08_15_preview
  output-folder: $(azure-libraries-for-java-folder)/sdk/containerservice/mgmt-v2023_08_15_preview
regenerate-manager: true
generate-interface: true
```

### Tag: package-2023-06-preview and java

These settings apply only when `--tag=package-2023-06-preview` is specified on the command line.
Please also specify `--azure-libraries-for-java-folder=<path to the root directory of your azure-sdk-for-java clone>`.

``` yaml $(tag) == 'package-2023-06-preview' && $(java) && $(multiapi)
java:
  namespace: com.microsoft.azure.management.containerservicefleet.v2023_06_15_preview
  output-folder: $(azure-libraries-for-java-folder)/sdk/containerservice/mgmt-v2023_06_15_preview
regenerate-manager: true
generate-interface: true
```

### Tag: package-2023-03-preview and java

These settings apply only when `--tag=package-2023-03-preview` is specified on the command line.
Please also specify `--azure-libraries-for-java-folder=<path to the root directory of your azure-sdk-for-java clone>`.

``` yaml $(tag) == 'package-2023-03-preview' && $(java) && $(multiapi)
java:
  namespace: com.microsoft.azure.management.containerservicefleet.v2023_03_15_preview
  output-folder: $(azure-libraries-for-java-folder)/sdk/containerservice/mgmt-v2023_03_15_preview
regenerate-manager: true
generate-interface: true
```

### Tag: package-2022-09-preview and java

These settings apply only when `--tag=package-2022-09-preview` is specified on the command line.
Please also specify `--azure-libraries-for-java-folder=<path to the root directory of your azure-sdk-for-java clone>`.

``` yaml $(tag) == 'package-2022-09-preview' && $(java) && $(multiapi)
java:
  namespace: com.microsoft.azure.management.containerservicefleet.v2022_09_02_preview
  output-folder: $(azure-libraries-for-java-folder)/sdk/containerservice/mgmt-v2022_09_02_preview
regenerate-manager: true
generate-interface: true
```

### Tag: package-2022-07-preview and java

These settings apply only when `--tag=package-2022-07-preview` is specified on the command line.
Please also specify `--azure-libraries-for-java-folder=<path to the root directory of your azure-sdk-for-java clone>`.

``` yaml $(tag) == 'package-2022-07-preview' && $(java) && $(multiapi)
java:
  namespace: com.microsoft.azure.management.containerservicefleet.v2022_07_02_preview
  output-folder: $(azure-libraries-for-java-folder)/sdk/containerservice/mgmt-v2022_07_02_preview
regenerate-manager: true
generate-interface: true
```

### Tag: package-2022-06-preview and java

These settings apply only when `--tag=package-2022-06-preview` is specified on the command line.
Please also specify `--azure-libraries-for-java-folder=<path to the root directory of your azure-sdk-for-java clone>`.

``` yaml $(tag) == 'package-2022-06-preview' && $(java) && $(multiapi)
java:
  namespace: com.microsoft.azure.management.containerservicefleet.v2022_06_02_preview
  output-folder: $(azure-libraries-for-java-folder)/sdk/containerservice/mgmt-v2022_06_02_preview
regenerate-manager: true
generate-interface: true
```
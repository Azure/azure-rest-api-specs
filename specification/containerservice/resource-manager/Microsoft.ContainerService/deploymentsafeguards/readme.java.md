## Java

These settings apply only when `--java` is specified on the command line and `--tag=profile-hybrid-2020-09-01` is not specified.
Please also specify `--azure-libraries-for-java-folder=<path to the root directory of your azure-libraries-for-java clone>`.

``` yaml $(java)
azure-arm: true
fluent: true
namespace: com.microsoft.azure.management.containerservice.safeguards
license-header: MICROSOFT_MIT_NO_CODEGEN
payload-flattening-threshold: 1
output-folder: $(azure-libraries-for-java-folder)/azure-mgmt-containerservicesafeguards
title: ContainerServiceSafeguardsManagementClient
description: "Azure Kubernetes Safeguards Client"
```

### Java multi-api

``` yaml $(java) && $(multiapi)
batch:
  - tag: package-2025-04-02-preview
  - tag: package-2025-04-01
  - tag: package-2025-05-02-preview
```

### Tag: package-2025-04-02-preview and java

These settings apply only when `--tag=package-2025-04-02-preview` is specified on the command line.
Please also specify `--azure-libraries-for-java-folder=<path to the root directory of your azure-sdk-for-java clone>`.

``` yaml $(tag) == 'package-2025-04-02-preview' && $(java) && $(multiapi)
java:
  namespace: com.microsoft.azure.management.containerservicesafeguards.v2025_04_02_preview
  output-folder: $(azure-libraries-for-java-folder)/sdk/containerservicesafeguards/mgmt-v2025_04_02_preview
regenerate-manager: true
generate-interface: true
```

### Tag: package-2025-04 and java

These settings apply only when `--tag=package-2025-04-01` is specified on the command line.
Please also specify `--azure-libraries-for-java-folder=<path to the root directory of your azure-sdk-for-java clone>`.

``` yaml $(tag) == 'package-2025-04-01' && $(java) && $(multiapi)
java:
  namespace: com.microsoft.azure.management.containerservicesafeguards.v2025_04_01
  output-folder: $(azure-libraries-for-java-folder)/sdk/containerservicesafeguards/mgmt-v2025_04_01
regenerate-manager: true
generate-interface: true
```

### Tag: package-2025-05-02-preview and java

These settings apply only when `--tag=package-2025-05-02-preview` is specified on the command line.
Please also specify `--azure-libraries-for-java-folder=<path to the root directory of your azure-sdk-for-java clone>`.

``` yaml $(tag) == 'package-2025-05-02-preview' && $(java) && $(multiapi)
java:
  namespace: com.microsoft.azure.management.containerservicesafeguards.v2025_05_02_preview
  output-folder: $(azure-libraries-for-java-folder)/sdk/containerservicesafeguards/mgmt-v2025_05_02_preview
regenerate-manager: true
generate-interface: true
```

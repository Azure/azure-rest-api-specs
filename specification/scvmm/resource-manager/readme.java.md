
These settings apply only when `--java` is specified on the command line.
Please also specify `--azure-libraries-for-java-folder=<path to the root directory of your azure-libraries-for-java clone>`.

``` yaml $(java)
azure-arm: true
fluent: true
namespace: com.microsoft.azure.management.scvmm
license-header: MICROSOFT_MIT_NO_CODEGEN
payload-flattening-threshold: 1
output-folder: $(azure-libraries-for-java-folder)/azure-mgmt-scvmm
title: SCVMMClient
description: "SCVMM Client"
```

### Java multi-api

``` yaml $(java) && $(multiapi)
batch:
  - tag: package-2020-06-05-preview
  - tag: package-2022-05-21-preview
```

### Tag: package-2020-06-05-preview and java

These settings apply only when `--tag=package-2020-06-05-preview` is specified on the command line.
Please also specify `--azure-libraries-for-java-folder=<path to the root directory of your azure-sdk-for-java clone>`.

``` yaml $(tag) == 'package-2020-06-05-preview' && $(java) && $(multiapi)
java:
  namespace: com.microsoft.azure.management.scvmm.v2020-06-05-preview
  output-folder: $(azure-libraries-for-java-folder)/scvmm/resource-manager/v2020-06-05-preview
regenerate-manager: true
generate-interface: true
```
### Tag: package-2022-05-21-preview and java

These settings apply only when `--tag=package-2022-05-21-preview` is specified on the command line.
Please also specify `--azure-libraries-for-java-folder=<path to the root directory of your azure-sdk-for-java clone>`.

``` yaml $(tag) == 'package-2022-05-21-preview' && $(java) && $(multiapi)
java:
  namespace: com.microsoft.azure.management.scvmm.v2022-05-21-preview
  output-folder: $(azure-libraries-for-java-folder)/scvmm/resource-manager/v2022-05-21-preview
regenerate-manager: true
generate-interface: true
```

These settings apply only when `--java` is specified on the command line.
Please also specify `--azure-libraries-for-java-folder=<path to the root directory of your azure-libraries-for-java clone>`.

``` yaml $(java)
azure-arm: true
fluent: true
namespace: com.azure.resourcemanager.resourcediscoverysap
license-header: MICROSOFT_MIT_NO_CODEGEN
payload-flattening-threshold: 1
output-folder: $(azure-libraries-for-java-folder)/azure-mgmt-resourcediscoverysap
title: ResourceDiscoverySAPClient
description: "Resource Discovery SAP Client"
```

### Java multi-api

``` yaml $(java) && $(multiapi)
batch:
  - tag: package-preview-2023-10
```

### Tag: package-preview-2023-10 and java

These settings apply only when `--tag=package-preview-2023-10` is specified on the command line.
Please also specify `--azure-libraries-for-java-folder=<path to the root directory of your azure-sdk-for-java clone>`.

``` yaml $(tag) == 'package-preview-2023-10' && $(java) && $(multiapi)
java:
  namespace: com.azure.resourcemanager.resourcediscoverysap.v2023_10_01_preview
  output-folder: $(azure-libraries-for-java-folder)/resourcediscoverysap/resource-manager/v2023_10_01_preview
regenerate-manager: true
generate-interface: true
```
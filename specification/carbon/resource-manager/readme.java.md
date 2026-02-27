## Java

These settings apply only when `--java` is specified on the command line.
Please also specify `--azure-libraries-for-java-folder=<path to the root directory of your azure-libraries-for-java clone>`.

``` yaml $(java)
azure-arm: true
fluent: true
namespace: com.azure.resourcemanager.carbonoptimization
license-header: MICROSOFT_MIT_NO_CODEGEN
payload-flattening-threshold: 1
output-folder: $(azure-libraries-for-java-folder)/azure-mgmt-carbonoptimization
title: CarbonOptimizationManagementClient
description: "Carbon Optimization Client"
```

### Java multi-api

``` yaml $(java) && $(multiapi)
batch:
  - tag: package-2023-04-01-preview
  - tag: package-2024-02-01-preview
  - tag: package-2025-04-01
```

These settings apply only when `--java` is specified on the command line.
Please also specify `--azure-libraries-for-java-folder=<path to the root directory of your azure-libraries-for-java clone>`.

``` yaml $(java)
azure-arm: true
fluent: true
namespace: com.microsoft.azure.management.hybridkubernetes
license-header: MICROSOFT_MIT_NO_CODEGEN
payload-flattening-threshold: 1
output-folder: $(azure-libraries-for-java-folder)/azure-mgmt-hybridkubernetes
title: HybridKubernetesManagementClient
description: "Hybrid Kubernetes Client"
```

### Java multi-api

``` yaml $(java) && $(multiapi)
batch:
  - tag: package-2020-01-01-preview
```

### Tag: package-2020-01-01-preview and java

These settings apply only when `--tag=package-2020-01-01-preview` is specified on the command line.
Please also specify `--azure-libraries-for-java-folder=<path to the root directory of your azure-sdk-for-java clone>`.

``` yaml $(tag) == 'package-2020-01-01-preview' && $(java) && $(multiapi)
java:
  namespace: com.microsoft.azure.management.hybridkubernetes.v2020_01_01_preview
  output-folder: $(azure-libraries-for-java-folder)/hybridkubernetes/resource-manager/v2020_01_01_preview
regenerate-manager: true
generate-interface: true
```
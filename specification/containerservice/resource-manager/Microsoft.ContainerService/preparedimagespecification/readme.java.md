## Java

These settings apply only when `--java` is specified on the command line.
Please also specify `--azure-libraries-for-java-folder=<path to the root directory of your azure-sdk-for-java clone>`.

```yaml $(java)
azure-arm: true
fluent: true
namespace: com.azure.resourcemanager.containerservice.preparedimgspec
license-header: MICROSOFT_MIT_NO_CODEGEN
payload-flattening-threshold: 1
output-folder: $(azure-libraries-for-java-folder)/azure-mgmt-containerservice-preparedimagespecification
title: ContainerServicePreparedImageSpecificationManagementClient
description: "Azure Kubernetes Prepared Image Specification Manager Client"
```

### Java multi-api

```yaml $(java) && $(multiapi)
batch:
  - tag: package-2026-02-02-preview
```

### Tag: package-2026-02-02-preview and java

These settings apply only when `--tag=package-2026-02-02-preview` is specified on the command line.
Please also specify `--azure-libraries-for-java-folder=<path to the root directory of your azure-sdk-for-java clone>`.

```yaml $(tag) == 'package-2026-02-02-preview' && $(java) && $(multiapi)
java:
  namespace: com.azure.resourcemanager.containerservice.preparedimgspec.v2026_02_02_preview
  output-folder: $(azure-libraries-for-java-folder)/sdk/containerservice/mgmt-v2026_02_02_preview
regenerate-manager: true
generate-interface: true
```

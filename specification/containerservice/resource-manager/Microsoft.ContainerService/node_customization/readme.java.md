## Java

These settings apply only when `--java` is specified on the command line and `--tag=profile-hybrid-2020-09-01` is not specified.
Please also specify `--azure-libraries-for-java-folder=<path to the root directory of your azure-libraries-for-java clone>`.

```yaml $(java)
azure-arm: true
fluent: true
namespace: com.azure.resourcemanager.containerservice.nodecustom
license-header: MICROSOFT_MIT_NO_CODEGEN
payload-flattening-threshold: 1
output-folder: $(azure-libraries-for-java-folder)/azure-mgmt-containerservice-nodecustomization
title: ContainerServiceNodeCustomizationManagementClient
description: "Azure Kubernetes Node Customization Manager Client"
```

### Java multi-api

```yaml $(java) && $(multiapi)
batch:
  - tag: package-2025-08-02-preview
  - tag: package-2025-09-02-preview
```

### Tag: package-2025-08-02-preview and java

These settings apply only when `--tag=package-2025-08-preview` is specified on the command line.
Please also specify `--azure-libraries-for-java-folder=<path to the root directory of your azure-sdk-for-java clone>`.

```yaml $(tag) == 'package-2025-08-02-preview' && $(java) && $(multiapi)
java:
  namespace: com.azure.resourcemanager.containerservice.nodecustom.v2025_08_02_preview
  output-folder: $(azure-libraries-for-java-folder)/sdk/containerservice/mgmt-v2025_08_02_preview
regenerate-manager: true
generate-interface: true
```

### Tag: package-2025-09-02-preview and java

These settings apply only when `--tag=package-2025-09-02-preview` is specified on the command line.
Please also specify `--azure-libraries-for-java-folder=<path to the root directory of your azure-sdk-for-java clone>`.

```yaml $(tag) == 'package-2025-09-preview' && $(java) && $(multiapi)
java:
  namespace: com.azure.resourcemanager.containerservice.nodecustom.v2025_09_02_preview
  output-folder: $(azure-libraries-for-java-folder)/sdk/containerservice/mgmt-v2025_09_02_preview
regenerate-manager: true
generate-interface: true
```

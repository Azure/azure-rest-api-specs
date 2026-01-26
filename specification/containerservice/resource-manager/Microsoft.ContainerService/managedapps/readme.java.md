## Java

These settings apply only when `--java` is specified on the command line and `--tag=profile-hybrid-2020-09-01` is not specified.
Please also specify `--azure-libraries-for-java-folder=<path to the root directory of your azure-libraries-for-java clone>`.

``` yaml $(java)
azure-arm: true
fluent: true
namespace: com.microsoft.azure.management.containerservice.managedapps
license-header: MICROSOFT_MIT_NO_CODEGEN
payload-flattening-threshold: 1
output-folder: $(azure-libraries-for-java-folder)/azure-mgmt-containerservicemanagedapps
title: ContainerServiceManagedAppsManagementClient
description: "Azure Kubernetes Managed Apps Client"
```

### Java multi-api

``` yaml $(java) && $(multiapi)
batch:
  - tag: package-2026-06-02-preview
```

### Tag: package-2026-06-02-preview and java

These settings apply only when `--tag=package-2026-06-02-preview` is specified on the command line.
Please also specify `--azure-libraries-for-java-folder=<path to the root directory of your azure-sdk-for-java clone>`.

``` yaml $(tag) == 'package-2026-06-02-preview' && $(java) && $(multiapi)
java:
  namespace: com.microsoft.azure.management.containerservicemanagedapps.v2026_06_02_preview
  output-folder: $(azure-libraries-for-java-folder)/sdk/containerservicemanagedapps/mgmt-v2026_06_02_preview
regenerate-manager: true
generate-interface: true
```

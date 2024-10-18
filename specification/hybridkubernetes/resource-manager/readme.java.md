
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
  - tag: package-2021-04-01-preview
  - tag: package-2021-03-01
  - tag: package-2021-10-01
  - tag: package-2022-05-01-preview
  - tag: package-2022-10-01-preview
  - tag: package-2024-07-01-preview
  - tag: package-2024-07-15-preview
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
### Tag: package-2021-04-01-preview and java

These settings apply only when `--tag=package-2021-04-01-preview` is specified on the command line.
Please also specify `--azure-libraries-for-java-folder=<path to the root directory of your azure-sdk-for-java clone>`.

``` yaml $(tag) == 'package-2020-04-01-preview' && $(java) && $(multiapi)
java:
  namespace: com.microsoft.azure.management.hybridkubernetes.v2021_04_01_preview
  output-folder: $(azure-libraries-for-java-folder)/hybridkubernetes/resource-manager/v2021_04_01_preview
regenerate-manager: true
generate-interface: true
```
### Tag: package-2021-03-01 and java

These settings apply only when `--tag=package-2021-03-01` is specified on the command line.
Please also specify `--azure-libraries-for-java-folder=<path to the root directory of your azure-sdk-for-java clone>`.

``` yaml $(tag) == 'package-2021-03-01' && $(java) && $(multiapi)
java:
  namespace: com.microsoft.azure.management.hybridkubernetes.v2021_03_01
  output-folder: $(azure-libraries-for-java-folder)/hybridkubernetes/resource-manager/v2021_03_01
regenerate-manager: true
generate-interface: true
```
### Tag: package-2021-10-01 and java

These settings apply only when `--tag=package-2021-10-01` is specified on the command line.
Please also specify `--azure-libraries-for-java-folder=<path to the root directory of your azure-sdk-for-java clone>`.

``` yaml $(tag) == 'package-2021-10-01' && $(java) && $(multiapi)
java:
  namespace: com.microsoft.azure.management.hybridkubernetes.v2021_10_01
  output-folder: $(azure-libraries-for-java-folder)/hybridkubernetes/resource-manager/v2021_10_01
regenerate-manager: true
generate-interface: true
```
### Tag: package-2022-05-01-preview and java

These settings apply only when `--tag=package-2022-05-01-preview` is specified on the command line.
Please also specify `--azure-libraries-for-java-folder=<path to the root directory of your azure-sdk-for-java clone>`.

``` yaml $(tag) == 'package-2022-05-01-preview' && $(java) && $(multiapi)
java:
  namespace: com.microsoft.azure.management.hybridkubernetes.v2022_05_01_preview
  output-folder: $(azure-libraries-for-java-folder)/hybridkubernetes/resource-manager/v2022_05_01_preview
regenerate-manager: true
generate-interface: true
```
### Tag: package-2022-10-01-preview and java

These settings apply only when `--tag=package-2022-10-01-preview` is specified on the command line.
Please also specify `--azure-libraries-for-java-folder=<path to the root directory of your azure-sdk-for-java clone>`.

``` yaml $(tag) == 'package-2022-10-01-preview' && $(java) && $(multiapi)
java:
  namespace: com.microsoft.azure.management.hybridkubernetes.v2022_10_01_preview
  output-folder: $(azure-libraries-for-java-folder)/hybridkubernetes/resource-manager/v2022_10_01_preview
regenerate-manager: true
generate-interface: true
```
### Tag: package-2024-07-01-preview and java

These settings apply only when `--tag=package-2024-07-01-preview` is specified on the command line.
Please also specify `--azure-libraries-for-java-folder=<path to the root directory of your azure-sdk-for-java clone>`.

``` yaml $(tag) == 'package-2024-07-01-preview' && $(java) && $(multiapi)
java:
  namespace: com.microsoft.azure.management.hybridkubernetes.v2024_07_01_preview
  output-folder: $(azure-libraries-for-java-folder)/hybridkubernetes/resource-manager/v2024_07_01_preview
regenerate-manager: true
generate-interface: true
```
### Tag: package-2024-07-15-preview and java

These settings apply only when `--tag=package-2024-07-15-preview` is specified on the command line.
Please also specify `--azure-libraries-for-java-folder=<path to the root directory of your azure-sdk-for-java clone>`.

``` yaml $(tag) == 'package-2024-07-15-preview' && $(java) && $(multiapi)
java:
  namespace: com.microsoft.azure.management.hybridkubernetes.v2024_07_15_preview
  output-folder: $(azure-libraries-for-java-folder)/hybridkubernetes/resource-manager/v2024_07_15_preview
regenerate-manager: true
generate-interface: true
```
## Java

These settings apply only when `--java` is specified on the command line.
Please also specify `--azure-libraries-for-java-folder=<path to the root directory of your azure-libraries-for-java clone>`.

``` yaml $(java)
azure-arm: true
fluent: true
namespace: com.microsoft.azure.management.kubernetesconfiguration
license-header: MICROSOFT_MIT_NO_CODEGEN
payload-flattening-threshold: 1
output-folder: $(azure-libraries-for-java-folder)/azure-mgmt-kubernetesconfiguration
```

### Java multi-api

``` yaml $(java) && $(multiapi)
batch:
  - tag: package-2021-05-01-preview
  - tag: package-2021-03-01
  - tag: package-2020-07-01-preview
  - tag: package-2019-11-01-preview
```

### Tag: package-2021-05-01-preview and java

These settings apply only when `--tag=package-2021-05-01-preview --java` is specified on the command line.
Please also specify `--azure-libraries-for-java-folder=<path to the root directory of your azure-sdk-for-java clone>`.

``` yaml $(tag) == 'package-2021-05-01-preview' && $(java) && $(multiapi)
java:
  namespace: com.microsoft.azure.management.kubernetesconfiguration.v2021_05_01_preview
  output-folder: $(azure-libraries-for-java-folder)/sdk/kubernetesconfiguration/mgmt-v2021_05_01_preview
  regenerate-manager: true
  generate-interface: true
```

### Tag: package-2021-03-01 and java

These settings apply only when `--tag=package-2021-03-01 --java` is specified on the command line.
Please also specify `--azure-libraries-for-java-folder=<path to the root directory of your azure-sdk-for-java clone>`.

``` yaml $(tag) == 'package-2021-03-01' && $(java) && $(multiapi)
java:
  namespace: com.microsoft.azure.management.kubernetesconfiguration.v2021_03_01
  output-folder: $(azure-libraries-for-java-folder)/sdk/kubernetesconfiguration/mgmt_v2021_03_01
  regenerate-manager: true
  generate-interface: true
```

### Tag: package-2020-07-01-preview and java

These settings apply only when `--tag=package-2020-07-01-preview --java` is specified on the command line.
Please also specify `--azure-libraries-for-java-folder=<path to the root directory of your azure-sdk-for-java clone>`.

``` yaml $(tag) == 'package-2020-07-01-preview' && $(java) && $(multiapi)
java:
  namespace: com.microsoft.azure.management.kubernetesconfiguration.v2020_07_01_preview
  output-folder: $(azure-libraries-for-java-folder)/sdk/kubernetesconfiguration/mgmt-v2020_07_01_preview
  regenerate-manager: true
  generate-interface: true
```

### Tag: package-2019-11-01-preview and java

These settings apply only when `--tag=package-2019-11-01-preview --java` is specified on the command line.
Please also specify `--azure-libraries-for-java-folder=<path to the root directory of your azure-sdk-for-java clone>`.

``` yaml $(tag) == 'package-2019-11-01-preview' && $(java) && $(multiapi)
java:
  namespace: com.microsoft.azure.management.kubernetesconfiguration.v2019_11_01_preview
  output-folder: $(azure-libraries-for-java-folder)/sdk/kubernetesconfiguration/mgmt-v2019_11_01_preview
  regenerate-manager: true
  generate-interface: true
```

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
  - tag: package-source-control-configurations-2021-03
  - tag: package-source-control-configurations-preview-2020-10
  - tag: package-source-control-configurations-preview-2020-07
  - tag: package-source-control-configurations-preview-2019-11
  - tag: package-extensions-preview-2020-07
```

### Tag: package-source-control-configurations-2021-03 and java

These settings apply only when `--tag=package-source-control-configurations-2021-03 --java` is specified on the command line.
Please also specify `--azure-libraries-for-java-folder=<path to the root directory of your azure-sdk-for-java clone>`.

``` yaml $(tag) == 'package-source-control-configurations-2021-03' && $(java) && $(multiapi)
java:
  namespace: com.microsoft.azure.management.kubernetesconfiguration.source-control-configurations.v2021_03_01
  output-folder: $(azure-libraries-for-java-folder)/sdk/kubernetesconfiguration/source-control-configurations/mgmt-v2021_03_01
  regenerate-manager: true
  generate-interface: true
```

### Tag: package-source-control-configurations-preview-2020-10 and java

These settings apply only when `--tag=package-source-control-configurations-preview-2020-10 --java` is specified on the command line.
Please also specify `--azure-libraries-for-java-folder=<path to the root directory of your azure-sdk-for-java clone>`.

``` yaml $(tag) == 'package-source-control-configurations-preview-2020-10' && $(java) && $(multiapi)
java:
  namespace: com.microsoft.azure.management.kubernetesconfiguration.source-control-configurations.v2020_10_01_preview
  output-folder: $(azure-libraries-for-java-folder)/sdk/kubernetesconfiguration/source-control-configurations/mgmt-v2020_10_01_preview
  regenerate-manager: true
  generate-interface: true
```

### Tag: package-source-control-configurations-preview-2020-07 and java

These settings apply only when `--tag=package-source-control-configurations-preview-2020-07 --java` is specified on the command line.
Please also specify `--azure-libraries-for-java-folder=<path to the root directory of your azure-sdk-for-java clone>`.

``` yaml $(tag) == 'package-source-control-configurations-preview-2020-07' && $(java) && $(multiapi)
java:
  namespace: com.microsoft.azure.management.kubernetesconfiguration.source-control-configurations.v2020_07_01_preview
  output-folder: $(azure-libraries-for-java-folder)/sdk/kubernetesconfiguration/source-control-configurations/mgmt-v2020_07_01_preview
  regenerate-manager: true
  generate-interface: true
```

### Tag: package-source-control-configurations-preview-2019-11 and java

These settings apply only when `--tag=package-source-control-configurations-preview-2019-11 --java` is specified on the command line.
Please also specify `--azure-libraries-for-java-folder=<path to the root directory of your azure-sdk-for-java clone>`.

``` yaml $(tag) == 'package-source-control-configurations-preview-2019-11' && $(java) && $(multiapi)
java:
  namespace: com.microsoft.azure.management.kubernetesconfiguration.source-control-configurations.v2019_11_01_preview
  output-folder: $(azure-libraries-for-java-folder)/sdk/kubernetesconfiguration/source-control-configurations/mgmt-v2019_11_01_preview
  regenerate-manager: true
  generate-interface: true
```

### Tag: package-extensions-preview-2020-07 and java

These settings apply only when `--tag=package-extensions-preview-2020-07 --java` is specified on the command line.
Please also specify `--azure-libraries-for-java-folder=<path to the root directory of your azure-sdk-for-java clone>`.

``` yaml $(tag) == 'package-extensions-preview-2020-07' && $(java) && $(multiapi)
java:
  namespace: com.microsoft.azure.management.kubernetesconfiguration.extensions.v2020_07_01_preview
  output-folder: $(azure-libraries-for-java-folder)/sdk/kubernetesconfiguration/extensions/mgmt-v2020_07_01_preview
  regenerate-manager: true
  generate-interface: true
```
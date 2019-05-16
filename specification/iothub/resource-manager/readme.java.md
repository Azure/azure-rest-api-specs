## Java

These settings apply only when `--java` is specified on the command line.
Please also specify `--azure-libraries-for-java-folder=<path to the root directory of your azure-libraries-for-java clone>`.

``` yaml $(java)
azure-arm: true
fluent: true
namespace: com.microsoft.azure.management.iothub
license-header: MICROSOFT_MIT_NO_CODEGEN
payload-flattening-threshold: 1
output-folder: $(azure-libraries-for-java-folder)/azure-mgmt-iothub
```

### Java multi-api

``` yaml $(java) && $(multiapi)
batch:
  - tag: package-preview-2019-03
  - tag: package-2018-12-preview
  - tag: package-2018-04
```

### Tag: package-preview-2019-03

These settings apply only when `--tag=package-preview-2019-03 --java` is specified on the command line.
Please also specify `--azure-libraries-for-java-folder=<path to the root directory of your azure-sdk-for-java clone>`.

``` yaml $(tag) == 'package-preview-2019-03' && $(java) && $(multiapi)
java:
  namespace: com.microsoft.azure.management.iothub.v2019_03_22_preview
  output-folder: $(azure-libraries-for-java-folder)/iothub/resource-manager/v2019_03_22_preview
regenerate-manager: true
generate-interface: true
```

### Tag: package-2018-12-preview and java

These settings apply only when `--tag=package-2018-12-preview --java` is specified on the command line.
Please also specify `--azure-libraries-for-java-folder=<path to the root directory of your azure-sdk-for-java clone>`.

``` yaml $(tag) == 'package-2018-12-preview' && $(java) && $(multiapi)
java:
  namespace: com.microsoft.azure.management.iothub.v2018_12_01_preview
  output-folder: $(azure-libraries-for-java-folder)/iothub/resource-manager/v2018_12_01_preview
regenerate-manager: true
generate-interface: true
```

### Tag: package-2018-04 and java

These settings apply only when `--tag=package-2018-04 --java` is specified on the command line.
Please also specify `--azure-libraries-for-java-folder=<path to the root directory of your azure-sdk-for-java clone>`.

``` yaml $(tag) == 'package-2018-04' && $(java) && $(multiapi)
java:
  namespace: com.microsoft.azure.management.iothub.v2018_04_01
  output-folder: $(azure-libraries-for-java-folder)/iothub/resource-manager/v2018_04_01
regenerate-manager: true
generate-interface: true
```
## Java

These settings apply only when `--java` is specified on the command line.
Please also specify `--azure-libraries-for-java-folder=<path to the root directory of your azure-libraries-for-java clone>`.

``` yaml $(java)
azure-arm: true
fluent: true
namespace: com.microsoft.azure.management.maps
license-header: MICROSOFT_MIT_NO_CODEGEN
payload-flattening-threshold: 1
output-folder: $(azure-libraries-for-java-folder)/azure-mgmt-maps
```

### Java multi-api

``` yaml $(java) && $(multiapi)
batch:
  - tag: package-2017-01
  - tag: package-2018-05
  - tag: package-preview-2020-02
```

### Tag: package-preview-2020-02 and java

These settings apply only when `--tag=package-preview-2020-02 --java` is specified on the command line.
Please also specify `--azure-libraries-for-java=<path to the root directory of your azure-sdk-for-java clone>`.

``` yaml $(tag) == 'package-preview-2020-02' && $(java) && $(multiapi)
java:
  namespace: com.microsoft.azure.management.maps.v2020_02_01_preview
  output-folder: $(azure-libraries-for-java-folder)/sdk/maps/mgmt-v2020_02_01_preview
regenerate-manager: true
generate-interface: true
```

### Tag: package-2017-01 and java

These settings apply only when `--tag=package-2017-01 --java` is specified on the command line.
Please also specify `--azure-libraries-for-java=<path to the root directory of your azure-sdk-for-java clone>`.

``` yaml $(tag) == 'package-2017-01' && $(java) && $(multiapi)
java:
  namespace: com.microsoft.azure.management.maps.v2017_01_01_preview
  output-folder: $(azure-libraries-for-java-folder)/sdk/maps/mgmt-v2017_01_01_preview
regenerate-manager: true
generate-interface: true
```

### Tag: package-2018-05 and java

These settings apply only when `--tag=package-2018-05 --java` is specified on the command line.
Please also specify `--azure-libraries-for-java=<path to the root directory of your azure-sdk-for-java clone>`.

``` yaml $(tag) == 'package-2018-05' && $(java) && $(multiapi)
java:
  namespace: com.microsoft.azure.management.maps.v2018_05_01
  output-folder: $(azure-libraries-for-java-folder)/sdk/maps/mgmt-v2018_05_01
regenerate-manager: true
generate-interface: true
```

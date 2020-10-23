## Java

These settings apply only when `--java` is specified on the command line.
Please also specify `--azure-libraries-for-java-folder=<path to the root directory of your azure-libraries-for-java clone>`.

``` yaml $(java)
azure-arm: true
fluent: true
namespace: com.microsoft.azure.management.databoxedge
license-header: MICROSOFT_MIT_NO_CODEGEN
payload-flattening-threshold: 0
output-folder: $(azure-libraries-for-java-folder)/azure-mgmt-databoxedge
```

### Java multi-api

``` yaml $(java) && $(multiapi)
batch:
  - tag: package-2020-05-preview
  - tag: package-2019-08
  - tag: package-2019-07
  - tag: package-2019-03  
```

### Tag: package-2020-05-preview and java

These settings apply only when `--tag=package-2020-05-preview --java` is specified on the command line.
Please also specify `--azure-libraries-for-java-folder=<path to the root directory of your azure-sdk-for-java clone>`.

``` yaml $(tag) == 'package-2020-05-preview' && $(java) && $(multiapi)
java:
  namespace: com.microsoft.azure.management.databoxedge.v2020_05_01_preview
  output-folder: $(azure-libraries-for-java-folder)/sdk/databoxedge/v2020_05_01_preview
regenerate-manager: true
generate-interface: true
```

### Tag: package-2019-08 and java

These settings apply only when `--tag=package-2019-08 --java` is specified on the command line.
Please also specify `--azure-libraries-for-java-folder=<path to the root directory of your azure-sdk-for-java clone>`.

``` yaml $(tag) == 'package-2019-08' && $(java) && $(multiapi)
java:
  namespace: com.microsoft.azure.management.databoxedge.v2019_08_01
  output-folder: $(azure-libraries-for-java-folder)/sdk/databoxedge/mgmt-v2019_08_01
regenerate-manager: true
generate-interface: true
```

### Tag: package-2019-07 and java

These settings apply only when `--tag=package-2019-07 --java` is specified on the command line.
Please also specify `--azure-libraries-for-java-folder=<path to the root directory of your azure-sdk-for-java clone>`.

``` yaml $(tag) == 'package-2019-07' && $(java) && $(multiapi)
java:
  namespace: com.microsoft.azure.management.databoxedge.v2019_07_01
  output-folder: $(azure-libraries-for-java-folder)/sdk/databoxedge/mgmt-v2019_07_01
regenerate-manager: true
generate-interface: true
```

### Tag: package-2019-03 and java

These settings apply only when `--tag=package-2019-03 --java` is specified on the command line.
Please also specify `--azure-libraries-for-java-folder=<path to the root directory of your azure-sdk-for-java clone>`.

``` yaml $(tag) == 'package-2019-03' && $(java) && $(multiapi)
java:
  namespace: com.microsoft.azure.management.databoxedge.v2019_03_01
  output-folder: $(azure-libraries-for-java-folder)/sdk/databoxedge/mgmt-v2019_03_01
regenerate-manager: true
generate-interface: true
```
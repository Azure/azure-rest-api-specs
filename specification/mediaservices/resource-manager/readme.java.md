## Java

These settings apply only when `--java` is specified on the command line.
Please also specify `--azure-libraries-for-java-folder=<path to the root directory of your azure-libraries-for-java clone>`.

``` yaml $(java)
azure-arm: true
fluent: true
namespace: com.microsoft.azure.management.mediaservices
license-header: MICROSOFT_MIT_NO_CODEGEN
payload-flattening-threshold: 1
output-folder: $(azure-libraries-for-java-folder)/azure-mgmt-mediaservices
```

### Java multi-api

``` yaml $(java) && $(multiapi)
batch:
  - tag: package-2015-10
  - tag: package-2018-03-preview
  - tag: package-2018-06-preview
  - tag: package-2018-07
  - tag: package-2019-05-preview
  - tag: package-2020-05  
```

### Tag: package-2015-10 and java

These settings apply only when `--tag=package-2015-10 --java` is specified on the command line.
Please also specify the `--azure-libraries-for-java-folder=<path to the root directory of your azure-sdk-for-java clone>`.

``` yaml $(tag) == 'package-2015-10' && $(java) && $(multiapi)
java:
  namespace: com.microsoft.azure.management.mediaservices.v2015_10_01
  output-folder: $(azure-libraries-for-java-folder)/sdk/mediaservices/mgmt-v2015_10_01
regenerate-manager: true
generate-interface: true
```

### Tag: package-2018-03-preview and java

These settings apply only when `--tag=package-2018-03-preview --java` is specified on the command line.
Please also specify the `--azure-libraries-for-java-folder=<path to the root directory of your azure-sdk-for-java clone>`.

``` yaml $(tag) == 'package-2018-03-preview' && $(java) && $(multiapi)
java:
  namespace: com.microsoft.azure.management.mediaservices.v2018_03_30_preview
  output-folder: $(azure-libraries-for-java-folder)/sdk/mediaservices/mgmt-v2018_03_30_preview
regenerate-manager: true
generate-interface: true
```

### Tag: package-2018-06-preview and java

These settings apply only when `--tag=package-2018-06-preview --java` is specified on the command line.
Please also specify the `--azure-libraries-for-java-folder=<path to the root directory of your azure-sdk-for-java clone>`.

``` yaml $(tag) == 'package-2018-06-preview' && $(java) && $(multiapi)
java:
  namespace: com.microsoft.azure.management.mediaservices.v2018_06_01_preview
  output-folder: $(azure-libraries-for-java-folder)/sdk/mediaservices/mgmt-v2018_06_01_preview
regenerate-manager: true
generate-interface: true
```

### Tag: package-2018-07 and java

These settings apply only when `--tag=package-2018-07 --java` is specified on the command line.
Please also specify the `--azure-libraries-for-java-folder=<path to the root directory of your azure-sdk-for-java clone>`.

``` yaml $(tag) == 'package-2018-07' && $(java) && $(multiapi)
java:
  namespace: com.microsoft.azure.management.mediaservices.v2018_07_01
  output-folder: $(azure-libraries-for-java-folder)/sdk/mediaservices/mgmt-v2018_07_01
regenerate-manager: true
generate-interface: true
```

### Tag: package-2019-05-preview and java

These settings apply only when `--tag=package-2019-05-preview --java` is specified on the command line.
Please also specify the `--azure-libraries-for-java-folder=<path to the root directory of your azure-sdk-for-java clone>`.

``` yaml $(tag) == 'package-2019-05-preview' && $(java) && $(multiapi)
java:
  namespace: com.microsoft.azure.management.mediaservices.v2019_05_01_preview
  output-folder: $(azure-libraries-for-java-folder)/sdk/mediaservices/mgmt-v2019_05_01_preview
regenerate-manager: true
generate-interface: true
```

### Tag: package-2020-05 and java

These settings apply only when `--tag=package-2020-05 --java` is specified on the command line.
Please also specify the `--azure-libraries-for-java-folder=<path to the root directory of your azure-sdk-for-java clone>`.

``` yaml $(tag) == 'package-2020-05' && $(java) && $(multiapi)
java:
  namespace: com.microsoft.azure.management.mediaservices.v2020_05_01
  output-folder: $(azure-libraries-for-java-folder)/sdk/mediaservices/mgmt-v2020_05_01
regenerate-manager: true
generate-interface: true
```
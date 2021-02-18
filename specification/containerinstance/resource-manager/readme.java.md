## Java

These settings apply only when `--java` is specified on the command line.
Please also specify `--azure-libraries-for-java-folder=<path to the root directory of your azure-libraries-for-java clone>`.

``` yaml $(java)
azure-arm: true
fluent: true
namespace: com.microsoft.azure.management.containerinstance
license-header: MICROSOFT_MIT_NO_CODEGEN
payload-flattening-threshold: 1
output-folder: $(azure-libraries-for-java-folder)/azure-mgmt-containerinstance
```

### Java multi-api

``` yaml $(java) && $(multiapi)
batch:
  - tag: package-2019-12
  - tag: package-2018-10
  - tag: package-2018-04
  - tag: package-2018-02-preview
  - tag: package-2017-12-preview
  - tag: package-2017-10-preview
  - tag: package-2017-08-preview
```

### Tag: package-2019-12 and java

These settings apply only when `--tag=package-2019-12 --java` is specified on the command line.
Please also specify `--azure-libraries-for-java=<path to the root directory of your azure-sdk-for-java clone>`.

``` yaml $(tag) == 'package-2019-12' && $(java) && $(multiapi)
java:
  namespace: com.microsoft.azure.management.containerinstance.v2019_12_01
  output-folder: $(azure-libraries-for-java-folder)/sdk/containerinstance/mgmt-v2019_12_01
regenerate-manager: true
generate-interface: true
```

### Tag: package-2018-10 and java

These settings apply only when `--tag=package-2018-10 --java` is specified on the command line.
Please also specify `--azure-libraries-for-java=<path to the root directory of your azure-sdk-for-java clone>`.

``` yaml $(tag) == 'package-2018-10' && $(java) && $(multiapi)
java:
  namespace: com.microsoft.azure.management.containerinstance.v2018_10_01
  output-folder: $(azure-libraries-for-java-folder)/sdk/containerinstance/mgmt-v2018_10_01
regenerate-manager: true
generate-interface: true
```

### Tag: package-2018-04 and java

These settings apply only when `--tag=package-2018-04 --java` is specified on the command line.
Please also specify `--azure-libraries-for-java=<path to the root directory of your azure-sdk-for-java clone>`.

``` yaml $(tag) == 'package-2018-04' && $(java) && $(multiapi)
java:
  namespace: com.microsoft.azure.management.containerinstance.v2018_04_01
  output-folder: $(azure-libraries-for-java-folder)/sdk/containerinstance/mgmt-v2018_04_01
regenerate-manager: true
generate-interface: true
```

### Tag: package-2018-02-preview and java

These settings apply only when `--tag=package-2018-02-preview --java` is specified on the command line.
Please also specify `--azure-libraries-for-java=<path to the root directory of your azure-sdk-for-java clone>`.

``` yaml $(tag) == 'package-2018-02-preview' && $(java) && $(multiapi)
java:
  namespace: com.microsoft.azure.management.containerinstance.v2018_02_01_preview
  output-folder: $(azure-libraries-for-java-folder)/sdk/containerinstance/mgmt-v2018_02_01_preview
regenerate-manager: true
generate-interface: true
```

### Tag: package-2017-12-preview and java

These settings apply only when `--tag=package-2017-12-preview --java` is specified on the command line.
Please also specify `--azure-libraries-for-java=<path to the root directory of your azure-sdk-for-java clone>`.

``` yaml $(tag) == 'package-2017-12-preview' && $(java) && $(multiapi)
java:
  namespace: com.microsoft.azure.management.containerinstance.v2017_12_01_preview
  output-folder: $(azure-libraries-for-java-folder)/sdk/containerinstance/mgmt-v2017_12_01_preview
regenerate-manager: true
generate-interface: true
```

### Tag: package-2017-10-preview and java

These settings apply only when `--tag=package-2017-10-preview --java` is specified on the command line.
Please also specify `--azure-libraries-for-java=<path to the root directory of your azure-sdk-for-java clone>`.

``` yaml $(tag) == 'package-2017-10-preview' && $(java) && $(multiapi)
java:
  namespace: com.microsoft.azure.management.containerinstance.v2017_10_01_preview
  output-folder: $(azure-libraries-for-java-folder)/sdk/containerinstance/mgmt-v2017_10_01_preview
regenerate-manager: true
generate-interface: true
```

### Tag: package-2017-08-preview and java

These settings apply only when `--tag=package-2017-08-preview --java` is specified on the command line.
Please also specify `--azure-libraries-for-java=<path to the root directory of your azure-sdk-for-java clone>`.

``` yaml $(tag) == 'package-2017-08-preview' && $(java) && $(multiapi)
java:
  namespace: com.microsoft.azure.management.containerinstance.v2017_08_01_preview
  output-folder: $(azure-libraries-for-java-folder)/sdk/containerinstance/mgmt-v2017_08_01_preview
regenerate-manager: true
generate-interface: true
```
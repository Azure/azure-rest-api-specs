## Java

These settings apply only when `--java` is specified on the command line.
Please also specify `--azure-libraries-for-java-folder=<path to the root directory of your azure-libraries-for-java clone>`.

``` yaml $(java)
azure-arm: true
fluent: true
namespace: com.microsoft.azure.management.iotcentral
license-header: MICROSOFT_MIT_NO_CODEGEN
payload-flattening-threshold: 1
output-folder: $(azure-libraries-for-java-folder)/azure-mgmt-iotcentral
service-name: IoTCentral
```

### Java multi-api

``` yaml $(java) && $(multiapi)
batch:
  - tag: package-2018-09-01
  - tag: package-2017-07-01-privatepreview
```

### Tag: package-2018-09-01 and java

These settings apply only when `--tag=package-2018-09-01 --java` is specified on the command line.
Please also specify `--azure-libraries-for-java-folder=<path to the root directory of your azure-sdk-for-java clone>`.

``` yaml $(tag)=='package-2018-09-01' && $(java) && $(multiapi)
java:
  namespace: com.microsoft.azure.management.iotcentral.v2018_09_01
  output-folder: $(azure-libraries-for-java-folder)/sdk/iotcentral/mgmt-v2018_09_01
regenerate-manager: true
generate-interface: true
```

### Tag: package-2017-07-01-privatepreview and java

These settings apply only when `--tag=package-2017-07-01-privatepreview --java` is specified on the command line.
Please also specify `--azure-libraries-for-java-folder=<path to the root directory of your azure-sdk-for-java clone>`.

``` yaml $(tag)=='package-2017-07-01-privatepreview' && $(java) && $(multiapi)
java:
  namespace: com.microsoft.azure.management.iotcentral.v2017_07_01_privatepreview
  output-folder: $(azure-libraries-for-java-folder)/sdk/iotcentral/mgmt-v2017_07_01_privatepreview
regenerate-manager: true
generate-interface: true
```

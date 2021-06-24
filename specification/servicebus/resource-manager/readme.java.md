## Java

These settings apply only when `--java` is specified on the command line.
Please also specify `--azure-libraries-for-java-folder=<path to the root directory of your azure-libraries-for-java clone>`.

``` yaml $(java)
azure-arm: true
fluent: true
namespace: com.microsoft.azure.management.servicebus
license-header: MICROSOFT_MIT_NO_CODEGEN
payload-flattening-threshold: 1
output-folder: $(azure-libraries-for-java-folder)/azure-mgmt-servicebus
directive:
  rename-model:
    from: PremiumMessagingRegions
    to: PremiumMessagingRegion

```

### Java multi-api

``` yaml $(java) && $(multiapi)
batch:
  - tag: package-2015-08
  - tag: package-2017-04
  - tag: package-2018-01-preview
```

### Tag: package-2015-08 and java

These settings apply only when `--tag=package-2015-08 --java` is specified on the command line.
Please also specify `--azure-libraries-for-java=<path to the root directory of your azure-sdk-for-java clone>`.

``` yaml $(tag) == 'package-2015-08' && $(java) && $(multiapi)
java:
  namespace: com.microsoft.azure.management.servicebus.v2015_08_01
  output-folder: $(azure-libraries-for-java-folder)/sdk/servicebus/mgmt-v2015_08_01
regenerate-manager: true
generate-interface: true
```

### Tag: package-2017-04 and java

These settings apply only when `--tag=package-2017-04 --java` is specified on the command line.
Please also specify `--azure-libraries-for-java=<path to the root directory of your azure-sdk-for-java clone>`.

``` yaml $(tag) == 'package-2017-04' && $(java) && $(multiapi)
java:
  namespace: com.microsoft.azure.management.servicebus.v2017_04_01
  output-folder: $(azure-libraries-for-java-folder)/sdk/servicebus/mgmt-v2017_04_01
regenerate-manager: true
generate-interface: true
```

### Tag: package-2018-01-preview and java

These settings apply only when `--tag=package-2018-01-preview --java` is specified on the command line.
Please also specify `--azure-libraries-for-java=<path to the root directory of your azure-sdk-for-java clone>`.

``` yaml $(tag) == 'package-2018-01-preview' && $(java) && $(multiapi)
java:
  namespace: com.microsoft.azure.management.servicebus.v2018_01_01_preview
  output-folder: $(azure-libraries-for-java-folder)/sdk/servicebus/mgmt-v2018_01_01_preview
regenerate-manager: true
generate-interface: true
```
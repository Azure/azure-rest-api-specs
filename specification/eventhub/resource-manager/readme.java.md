## Java

These settings apply only when `--java` is specified on the command line.
Please also specify `--azure-libraries-for-java-folder=<path to the root directory of your azure-libraries-for-java clone>`.

``` yaml $(java)
azure-arm: true
fluent: true
namespace: com.microsoft.azure.management.eventhubs
license-header: MICROSOFT_MIT_NO_CODEGEN
payload-flattening-threshold: 1
output-folder: $(azure-libraries-for-java-folder)/azure-mgmt-eventhubs
service-name: EventHubs
```

### Java multi-api

``` yaml $(java) && $(multiapi)
batch:
  - tag: package-2022-10-preview
  - tag: package-2022-01-preview
  - tag: package-2021-11
  - tag: package-2021-06-preview
  - tag: package-2021-01-preview
  - tag: package-2018-01-preview
  - tag: package-2015-08
  - tag: package-2017-04
```

### Tag: package-2021-11 and java

These settings apply only when `--tag=package-2021-11 --java` is specified on the command line.
Please also specify `--azure-libraries-for-java=<path to the root directory of your azure-sdk-for-java clone>`.

``` yaml $(tag) == 'package-2021-11' && $(java) && $(multiapi)
java:
  namespace: com.microsoft.azure.management.eventhubs.v2021_11_01
  output-folder: $(azure-libraries-for-java-folder)/sdk/eventhubs/mgmt-v2021_11_01
regenerate-manager: true
generate-interface: true
```

### Tag: package-2021-06-preview and java

These settings apply only when `--tag=package-2021-06-preview --java` is specified on the command line.
Please also specify `--azure-libraries-for-java=<path to the root directory of your azure-sdk-for-java clone>`.

``` yaml $(tag) == 'package-2021-06-preview' && $(java) && $(multiapi)
java:
  namespace: com.microsoft.azure.management.eventhubs.v2021_06_01_preview
  output-folder: $(azure-libraries-for-java-folder)/sdk/eventhubs/mgmt-v2021_06_01_preview
regenerate-manager: true
generate-interface: true
```

### Tag: package-2022-01-preview and java

These settings apply only when `--tag=package-2022-01-preview --java` is specified on the command line.
Please also specify `--azure-libraries-for-java=<path to the root directory of your azure-sdk-for-java clone>`.

``` yaml $(tag) == 'package-2022-01-preview' && $(java) && $(multiapi)
java:
  namespace: com.microsoft.azure.management.eventhubs.v2022_01_01_preview
  output-folder: $(azure-libraries-for-java-folder)/sdk/eventhubs/mgmt-v2022_01_01_preview
regenerate-manager: true
generate-interface: true
```

### Tag: package-2022-10-preview and java

These settings apply only when `--tag=package-2022-10-preview --java` is specified on the command line.
Please also specify `--azure-libraries-for-java=<path to the root directory of your azure-sdk-for-java clone>`.

``` yaml $(tag) == 'package-2022-10-preview' && $(java) && $(multiapi)
java:
  namespace: com.microsoft.azure.management.eventhubs.v2022_10_01_preview
  output-folder: $(azure-libraries-for-java-folder)/sdk/eventhubs/mgmt-v2022_10_01_preview
regenerate-manager: true
generate-interface: true
```

### Tag: package-2021-01-preview and java

These settings apply only when `--tag=package-2021-01-preview --java` is specified on the command line.
Please also specify `--azure-libraries-for-java=<path to the root directory of your azure-sdk-for-java clone>`.

``` yaml $(tag) == 'package-2021-01-preview' && $(java) && $(multiapi)
java:
  namespace: com.microsoft.azure.management.eventhubs.v2021_01_01_preview
  output-folder: $(azure-libraries-for-java-folder)/sdk/eventhubs/mgmt-v2021_01_01_preview
regenerate-manager: true
generate-interface: true
```

### Tag: package-2018-01-preview and java

These settings apply only when `--tag=package-2018-01-preview --java` is specified on the command line.
Please also specify `--azure-libraries-for-java=<path to the root directory of your azure-sdk-for-java clone>`.

``` yaml $(tag) == 'package-2018-01-preview' && $(java) && $(multiapi)
java:
  namespace: com.microsoft.azure.management.eventhubs.v2018_01_01_preview
  output-folder: $(azure-libraries-for-java-folder)/sdk/eventhubs/mgmt-v2018_01_01_preview
regenerate-manager: true
generate-interface: true
```

### Tag: package-2015-08 and java

These settings apply only when `--tag=package-2015-08 --java` is specified on the command line.
Please also specify `--azure-libraries-for-java=<path to the root directory of your azure-sdk-for-java clone>`.

``` yaml $(tag) == 'package-2015-08' && $(java) && $(multiapi)
java:
  namespace: com.microsoft.azure.management.eventhubs.v2015_08_01
  output-folder: $(azure-libraries-for-java-folder)/sdk/eventhubs/mgmt-v2015_08_01
regenerate-manager: true
generate-interface: true
```

### Tag: package-2017-04 and java

These settings apply only when `--tag=package-2017-04 --java` is specified on the command line.
Please also specify `--azure-libraries-for-java=<path to the root directory of your azure-sdk-for-java clone>`.

``` yaml $(tag) == 'package-2017-04' && $(java) && $(multiapi)
java:
  namespace: com.microsoft.azure.management.eventhubs.v2017_04_01
  output-folder: $(azure-libraries-for-java-folder)/sdk/eventhubs/mgmt-v2017_04_01
regenerate-manager: true
generate-interface: true
```

### Tag: profile-hybrid-2020-09-01 and java

These settings apply only when `--tag=profile-hybrid-2020-09-01 --java` is specified on the command line.
Please also specify `--azure-libraries-for-java-folder=<path to the root directory of your azure-sdk-for-java clone>`.

``` yaml $(tag) == 'profile-hybrid-2020-09-01' && $(java)
input-file:
  - Microsoft.EventHub/preview/2018-01-01-preview/AvailableClusterRegions-preview.json
  - Microsoft.EventHub/preview/2018-01-01-preview/Clusters-preview.json
  - Microsoft.EventHub/preview/2018-01-01-preview/namespaces-preview.json
  - Microsoft.EventHub/stable/2017-04-01/AuthorizationRules.json
  - Microsoft.EventHub/stable/2017-04-01/CheckNameAvailability.json
  - Microsoft.EventHub/stable/2017-04-01/consumergroups.json
  - Microsoft.EventHub/stable/2017-04-01/operations.json
  - Microsoft.EventHub/stable/2017-04-01/eventhubs.json
  - Microsoft.EventHub/stable/2017-04-01/sku.json
  - Microsoft.EventHub/stable/2017-04-01/disasterRecoveryConfigs.json
  - Microsoft.EventHub/stable/2017-04-01/networkRuleSets.json
```

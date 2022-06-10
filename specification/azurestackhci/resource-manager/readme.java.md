## Java

These settings apply only when `--java` is specified on the command line.
Please also specify `--azure-libraries-for-java-folder=<path to the root directory of your azure-libraries-for-java clone>`.

``` yaml $(java)
azure-arm: true
fluent: true
namespace: com.microsoft.azure.management.azurestackhci
license-header: MICROSOFT_MIT_NO_CODEGEN
payload-flattening-threshold: 1
output-folder: $(azure-libraries-for-java-folder)/azure-mgmt-azurestackhci
directive:
  - from: arcSettings.json
    where: $.definitions.ArcSetting.properties.systemData
    transform: $['x-ms-client-flatten'] = false
    reason: systemData should not be flattened
  - from: clusters.json
    where: $.definitions.Cluster.properties.systemData
    transform: $['x-ms-client-flatten'] = false
    reason: systemData should not be flattened
  - from: extensions.json
    where: $.definitions.Extension.properties.systemData
    transform: $['x-ms-client-flatten'] = false
    reason: systemData should not be flattened
```

# Validation


### Java multi-api

``` yaml $(java) && $(multiapi)
batch:
  - tag: package-2020-10
```

### Tag: package-2020-10 and java

These settings apply only when `--tag=package-2020-10 --java` is specified on the command line.
Please also specify `--azure-libraries-for-java=<path to the root directory of your azure-sdk-for-java clone>`.

``` yaml $(tag) == 'package-2020-10' && $(java) && $(multiapi)
java:
  namespace: com.microsoft.azure.management.azurestackhci.v2020_10_01
  output-folder: $(azure-libraries-for-java-folder)/sdk/azurestackhci/mgmt-v2020_10_01
regenerate-manager: true
generate-interface: true
```

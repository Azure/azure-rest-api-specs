## Java

These settings apply only when `--java` is specified on the command line.
Please also specify `--azure-libraries-for-java-folder=<path to the root directory of your azure-libraries-for-java clone>`.

```yaml $(java)
azure-arm: true
fluent: true
namespace: com.microsoft.azure.management.exposurecontrol
license-header: MICROSOFT_MIT_NO_CODEGEN
payload-flattening-threshold: 1
output-folder: $(azure-libraries-for-java-folder)/azure-mgmt-exposurecontrol
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

```yaml $(java) && $(multiapi)
batch:
  - tag: package-2024-01
```

### Tag: package-2023-04 and java

These settings apply only when `--tag=package-2024-01 --java` is specified on the command line.
Please also specify `--azure-libraries-for-java=<path to the root directory of your azure-sdk-for-java clone>`.

```yaml $(tag) == 'package-2024-01' && $(java) && $(multiapi)
java:
  namespace: com.microsoft.azure.management.exposurecontrol.v2024_01_01_privatepreview
  output-folder: $(azure-libraries-for-java-folder)/sdk/exposurecontrol/mgmt-v2024_01_01_privatepreview
regenerate-manager: true
generate-interface: true
```

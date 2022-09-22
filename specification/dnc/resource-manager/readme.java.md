# Java ADT

> see https://aka.ms/autorest

This is the AutoRest configuration file for Azure Digital Twins.

## Java common settings

These settings apply only when `--java` is specified on the command line.
Please also specify `--azure-libraries-for-java-folder=<path to the root directory of your azure-libraries-for-java clone>`.

```yaml $(java)
azure-arm: true
fluent: true
namespace: com.microsoft.azure.management.delegatednetwork
license-header: MICROSOFT_MIT_NO_CODEGEN
payload-flattening-threshold: 1
output-folder: $(azure-libraries-for-java-folder)/azure-mgmt-delegatednetwork
```

### Java multi-api

```yaml $(java) && $(multiapi)
batch:
  - tag: package-2021-03-15
  - tag: package-2020-08-08-preview
```

### Tag: package-2021-03-15 and java

These settings apply only when `--tag=package-2021-03-15 --java` is specified on the command line.
Please also specify `--azure-libraries-for-java=<path to the root directory of your azure-sdk-for-java clone>`.

```yaml $(tag) == 'package-2021-03-15' && $(java) && $(multiapi)
java:
  namespace: com.microsoft.azure.management.delegatednetwork.v2021_03_15
  output-folder: $(azure-libraries-for-java-folder)/sdk/delegatednetwork/mgmt-v2021_03_15
  regenerate-manager: true
  generate-interface: true
```

### Tag: package-2020-08-08-preview and java

These settings apply only when `--tag=package-2020-08-08-preview --java` is specified on the command line.
Please also specify `--azure-libraries-for-java=<path to the root directory of your azure-sdk-for-java clone>`.

```yaml $(tag) == 'package-2020-08-08-preview' && $(java) && $(multiapi)
java:
  namespace: com.microsoft.azure.management.delegatednetwork.v2020_08_08_preview
  output-folder: $(azure-libraries-for-java-folder)/sdk/delegatednetwork/mgmt-v2020_08_08_preview
  regenerate-manager: true
  generate-interface: true
```

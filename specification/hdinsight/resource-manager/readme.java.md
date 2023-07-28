## Java

These settings apply only when `--java` is specified on the command line.
Please also specify `--azure-libraries-for-java-folder=<path to the root directory of your azure-libraries-for-java clone>`.

``` yaml $(java)
azure-arm: true
fluent: true
namespace: com.microsoft.azure.management.hdinsightaks
license-header: MICROSOFT_MIT_NO_CODEGEN
payload-flattening-threshold: 1
output-folder: $(azure-libraries-for-java-folder)/azure-mgmt-hdinsightaks

rename-model: 'SubResource:EntityResource'
```

### Java multi-api

``` yaml $(java) && $(multiapi)
batch:
  - tag: package-2021-09-preview
  - tag: package-2023-06-preview
```

### Tag: package-2023-06-preview and java

These settings apply only when `--tag=package-2023-06-preview --java` is specified on the command line.

Please also specify `--azure-libraries-for-java=<path to the root directory of your azure-sdk-for-java clone>`.

``` yaml $(tag) == 'package-2023-06-preview' && $(java) && $(multiapi)
java:
  namespace: com.microsoft.azure.management.hdinsightaks.v2023_06_01_preview
  output-folder: $(azure-libraries-for-java-folder)/sdk/hdinsightaks/mgmt-v2023_06_01_preview
regenerate-manager: true
generate-interface: true
```

### Tag: package-2021-09-preview and java

These settings apply only when `--tag=package-2021-09-preview --java` is specified on the command line.

Please also specify `--azure-libraries-for-java=<path to the root directory of your azure-sdk-for-java clone>`.

``` yaml $(tag) == 'package-2021-09-15-preview' && $(java) && $(multiapi)
java:
  namespace: com.microsoft.azure.management.hdinsightaks.v2021_09_15_preview
  output-folder: $(azure-libraries-for-java-folder)/sdk/hdinsightaks/mgmt-v2021_09_15_preview
regenerate-manager: true
generate-interface: true
```
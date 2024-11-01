## Java

These settings apply only when `--java` is specified on the command line.
Please also specify `--azure-libraries-for-java-folder=<path to the root directory of your azure-libraries-for-java clone>`.

``` yaml $(java)
azure-arm: true
fluent: true
namespace: com.azure.resourcemanager.migration.modernization
license-header: MICROSOFT_MIT_NO_CODEGEN
payload-flattening-threshold: 1
output-folder: $(azure-libraries-for-java-folder)/azure-mgmt-migrationmodernization
```

### Java multi-api

``` yaml $(java) && $(multiapi)
batch:
  - tag: package-preview-2022-05
```

### Tag: package-preview-2022-05 and java

These settings apply only when `--tag=package-preview-2022-05 --java` is specified on the command line.
Please also specify `--azure-libraries-for-java=<path to the root directory of your azure-sdk-for-java clone>`.

``` yaml $(tag) == 'package-preview-2022-05' && $(java) && $(multiapi)
java:
  namespace: com.azure.resourcemanager.migration.modernization.v2022_05_01
  output-folder: $(azure-libraries-for-java-folder)/sdk/migrationmodernization/mgmt-v2022_05_01
regenerate-manager: true
generate-interface: true
```

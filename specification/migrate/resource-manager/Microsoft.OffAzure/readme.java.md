## Java

These settings apply only when `--java` is specified on the command line.
Please also specify `--azure-libraries-for-java-folder=<path to the root directory of your azure-libraries-for-java clone>`.

``` yaml $(java)
azure-arm: true
fluent: true
namespace: com.azure.resourcemanager.migrationdiscovery
license-header: MICROSOFT_MIT_NO_CODEGEN
payload-flattening-threshold: 1
output-folder: $(azure-libraries-for-java-folder)/azure-mgmt-migrationdiscovery
```

### Java multi-api

``` yaml $(java) && $(multiapi)
batch:
  - tag: package-2020-01
  - tag: package-2020-07
```

### Tag: package-preview-2023-10 and java

These settings apply only when `--tag=package-preview-2023-10 --java` is specified on the command line.
Please also specify `--azure-libraries-for-java=<path to the root directory of your azure-sdk-for-java clone>`.

``` yaml $(tag) == 'package-preview-2023-10' && $(java)
java:
  namespace: com.azure.resourcemanager.migrationdiscovery.v2023_10_01
  output-folder: $(azure-libraries-for-java-folder)/sdk/migrationdiscovery/mgmt-v2023_10_01
regenerate-manager: true
generate-interface: true
```

### Tag: package-2023-06 and java

These settings apply only when `--tag=package-2023-06 --java` is specified on the command line.
Please also specify `--azure-libraries-for-java=<path to the root directory of your azure-sdk-for-java clone>`.

``` yaml $(tag) == 'package-2023-06' && $(java)
java:
  namespace: com.azure.resourcemanager.migrationdiscovery.v2023_06_06
  output-folder: $(azure-libraries-for-java-folder)/sdk/migrationdiscovery/mgmt-v2023_06_06
regenerate-manager: true
generate-interface: true
```

### Tag: package-2020-01 and java

These settings apply only when `--tag=package-2020-01 --java` is specified on the command line.
Please also specify `--azure-libraries-for-java=<path to the root directory of your azure-sdk-for-java clone>`.

``` yaml $(tag) == 'package-2020-01' && $(java) && $(multiapi)
java:
  namespace: com.azure.resourcemanager.migrationdiscovery.v2020_01_01
  output-folder: $(azure-libraries-for-java-folder)/sdk/migrationdiscovery/mgmt-v2020_01_01
regenerate-manager: true
generate-interface: true
```

### Tag: package-2020-07 and java

These settings apply only when `--tag=package-2020-07 --java` is specified on the command line.
Please also specify `--azure-libraries-for-java=<path to the root directory of your azure-sdk-for-java clone>`.

``` yaml $(tag) == 'package-2020-07' && $(java) && $(multiapi)
java:
  namespace: com.azure.resourcemanager.migrationdiscovery.v2020_07_07
  output-folder: $(azure-libraries-for-java-folder)/sdk/migrationdiscovery/mgmt-v2020_07_07
regenerate-manager: true
generate-interface: true
```

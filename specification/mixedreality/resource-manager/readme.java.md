## Java

These settings apply only when `--java` is specified on the command line.
Please also specify `--azure-libraries-for-java-folder=<path to the root directory of your azure-libraries-for-java clone>`.

``` yaml $(java)
azure-arm: true
fluent: true
namespace: com.microsoft.azure.management.mixedreality
license-header: MICROSOFT_MIT_NO_CODEGEN
payload-flattening-threshold: 1
output-folder: $(azure-libraries-for-java-folder)/azure-mgmt-mixedreality
```

### Java multi-api

``` yaml $(java) && $(multiapi)
batch:
  - tag: package-2025-01
  - tag: package-2021-01
  - tag: package-2020-05
```

### Tag: package-2025-01 and java

These settings apply only when `--tag=package-2025-01 --java` is specified on the command line.
Please also specify `--azure-libraries-for-java-folder=<path to the root directory of your azure-sdk-for-java clone>`.

``` yaml $(tag) == 'package-2025-01' && $(java) && $(multiapi)
java:
  namespace: com.microsoft.azure.management.mixedreality.v2025_01
  output-folder: $(azure-libraries-for-java-folder)/sdk/mixedreality/mgmt-v2025_01
regenerate-manager: true
generate-interface: true
```

### Tag: package-2021-01 and java

These settings apply only when `--tag=package-2021-01 --java` is specified on the command line.
Please also specify `--azure-libraries-for-java-folder=<path to the root directory of your azure-sdk-for-java clone>`.

``` yaml $(tag) == 'package-2021-01' && $(java) && $(multiapi)
java:
  namespace: com.microsoft.azure.management.mixedreality.v2021_01_01
  output-folder: $(azure-libraries-for-java-folder)/sdk/mixedreality/mgmt-v2021_01_01
regenerate-manager: true
generate-interface: true
```

### Tag: package-2020-05 and java

These settings apply only when `--tag=package-2020-05 --java` is specified on the command line.
Please also specify `--azure-libraries-for-java-folder=<path to the root directory of your azure-sdk-for-java clone>`.

``` yaml $(tag) == 'package-2020-05' && $(java) && $(multiapi)
java:
  namespace: com.microsoft.azure.management.mixedreality.v2020_05_01
  output-folder: $(azure-libraries-for-java-folder)/sdk/mixedreality/mgmt-v2020_05_01
regenerate-manager: true
generate-interface: true
```

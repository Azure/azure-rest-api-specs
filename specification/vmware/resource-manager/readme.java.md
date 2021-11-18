## Java

These settings apply only when `--java` is specified on the command line.
Please also specify `--azure-libraries-for-java-folder=<path to the root directory of your azure-libraries-for-java clone>`.

``` yaml $(java)
azure-arm: true
fluent: true
namespace: com.microsoft.azure.management.avs
override-client-name: AvsClient
license-header: MICROSOFT_MIT_NO_CODEGEN
output-folder: $(azure-libraries-for-java-folder)/azure-mgmt-avs
```

### Java multi-api

``` yaml $(java) && $(multiapi)
batch:
  - tag: package-2021-12-01
  - tag: package-2021-06-01
  - tag: package-2021-01-01-preview
  - tag: package-2020-07-17-preview
  - tag: package-2020-03-20
```

### Tag: package-2021-12-01 and java

These settings apply only when `--tag=package-2021-12-01 --java` is specified on the command line.
Please also specify the `--azure-libraries-for-java-folder=<path to the root directory of your azure-sdk-for-java clone>`.

``` yaml $(tag) == 'package-2021-12-01' && $(java) && $(multiapi)
java:
  namespace: com.microsoft.azure.management.avs.v2021_12_01
  output-folder: $(azure-libraries-for-java-folder)/sdk/avs/mgmt-v2021_12_01
regenerate-manager: true
generate-interface: true
```

### Tag: package-2021-06-01 and java

These settings apply only when `--tag=package-2021-06-01 --java` is specified on the command line.
Please also specify the `--azure-libraries-for-java-folder=<path to the root directory of your azure-sdk-for-java clone>`.

``` yaml $(tag) == 'package-2021-06-01' && $(java) && $(multiapi)
java:
  namespace: com.microsoft.azure.management.avs.v2021_06_01
  output-folder: $(azure-libraries-for-java-folder)/sdk/avs/mgmt-v2021_06_01
regenerate-manager: true
generate-interface: true
```

### Tag: package-2021-01-01-preview and java

These settings apply only when `--tag=package-2021-01-01-preview -java` is specified on the command line.
Please also specify the `--azure-libraries-for-java-folder=<path to the root directory of your azure-sdk-for-java clone>`.

``` yaml $(tag) == 'package-2021-01-01-preview' && $(java) && $(multiapi)
java:
  namespace: com.microsoft.azure.management.avs.v2021_01_01_preview
  output-folder: $(azure-libraries-for-java-folder)/sdk/avs/mgmt-v2021_01_01_preview
regenerate-manager: true
generate-interface: true
```

### Tag: package-2020-07-17-preview and java

These settings apply only when `--tag=package-2020-07-17-preview -java` is specified on the command line.
Please also specify the `--azure-libraries-for-java-folder=<path to the root directory of your azure-sdk-for-java clone>`.

``` yaml $(tag) == 'package-2020-07-17-preview' && $(java) && $(multiapi)
java:
  namespace: com.microsoft.azure.management.avs.v2020_07_17_preview
  output-folder: $(azure-libraries-for-java-folder)/sdk/avs/mgmt-v2020_07_17_preview
regenerate-manager: true
generate-interface: true
```

### Tag: package-2020-03-20 and java

These settings apply only when `--tag=package-2020-03-20 --java` is specified on the command line.
Please also specify the `--azure-libraries-for-java-folder=<path to the root directory of your azure-sdk-for-java clone>`.

``` yaml $(tag) == 'package-2020-03-20' && $(java) && $(multiapi)
java:
  namespace: com.microsoft.azure.management.avs.v2020_03_20
  output-folder: $(azure-libraries-for-java-folder)/sdk/avs/mgmt-v2020_03_20
regenerate-manager: true
generate-interface: true
```

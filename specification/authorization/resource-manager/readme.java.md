## Java

These settings apply only when `--java` is specified on the command line.
Please also specify `--azure-libraries-for-java-folder=<path to the root directory of your azure-libraries-for-java clone>`.

``` yaml $(java)
azure-arm: true
fluent: true
namespace: com.microsoft.azure.management.authorization
license-header: MICROSOFT_MIT_NO_CODEGEN
payload-flattening-threshold: 1
output-folder: $(azure-libraries-for-java-folder)/azure-mgmt-authorization
```

### Java multi-api

``` yaml $(java) && $(multiapi)
batch:
  - tag: package-2018-09-01-preview
  - tag: package-2018-07-01-preview-only
  - tag: package-2015-06-01-preview
  - tag: package-2018-05-01-preview
  - tag: package-2020-10-01-preview
  - tag: package-2021-01-01-preview-only
  - tag: package-2021-03-01-preview-only
  - tag: package-2021-07-01-preview-only
```

### Tag: package-2021-07-01-preview-only and java

These settings apply only when `--tag=package-2021-07-01-preview-only --java` is specified on he command line.
Please also specify `--azure-libraries-for-java-folder=<path to the root directory of your azure-sdk-for-java clone>`.

``` yaml $(tag) == 'package-2021-07-01-preview-only' && $(java) && $(multiapi)
java:
  namespace: com.microsoft.azure.management.authorization.v2021_07_01_preview
  output-folder: $(azure-libraries-for-java-folder)/sdk/authorization/mgmt-v2021_07_01_preview
regenerate-manager: true
generate-interface: true
```

### Tag: package-2021-03-01-preview-only and java

These settings apply only when `--tag=package-2021-03-01-preview-only --java` is specified on he command line.
Please also specify `--azure-libraries-for-java-folder=<path to the root directory of your azure-sdk-for-java clone>`.

``` yaml $(tag) == 'package-2021-03-01-preview-only' && $(java) && $(multiapi)
java:
  namespace: com.microsoft.azure.management.authorization.v2021_03_01_preview
  output-folder: $(azure-libraries-for-java-folder)/sdk/authorization/mgmt-v2021_03_01_preview
regenerate-manager: true
generate-interface: true
```

### Tag: package-2018-09-01-preview and java

These settings apply only when `--tag=package-2018-09-01-preview --java` is specified on he command line.
Please also specify `--azure-libraries-for-java-folder=<path to the root directory of your azure-sdk-for-java clone>`.

``` yaml $(tag) == 'package-2018-09-01-preview' && $(java) && $(multiapi)
java:
  namespace: com.microsoft.azure.management.authorization.v2018_09_01_preview
  output-folder: $(azure-libraries-for-java-folder)/sdk/authorization/mgmt-v2018_09_01_preview
regenerate-manager: true
generate-interface: true
```

### Tag: package-2018-07-01-preview-only and java

These settings apply only when `--tag=package-2018-07-01-preview-only --java` is specified on he command line.
Please also specify `--azure-libraries-for-java-folder=<path to the root directory of your azure-sdk-for-java clone>`.

``` yaml $(tag) == 'package-2018-07-01-preview-only' && $(java) && $(multiapi)
java:
  namespace: com.microsoft.azure.management.authorization.v2018_07_01_preview
  output-folder: $(azure-libraries-for-java-folder)/sdk/authorization/mgmt-v2018_07_01_preview
regenerate-manager: true
generate-interface: true
```

### Tag: package-2018-05-01-preview and java

These settings apply only when `--tag=package-2018-05-01-preview --java` is specified on he command line.
Please also specify `--azure-libraries-for-java-folder=<path to the root directory of your azure-sdk-for-java clone>`.

``` yaml $(tag) == 'package-2018-05-01-preview' && $(java) && $(multiapi)
java:
  namespace: com.microsoft.azure.management.authorization.v2018_05_01_preview
  output-folder: $(azure-libraries-for-java-folder)/sdk/authorization/mgmt-v2018_05_01_preview
regenerate-manager: true
generate-interface: true
```

### Tag: package-2015-07-01 and java

These settings apply only when `--tag=package-2015-07-01 --java` is specified on he command line.
Please also specify `--azure-libraries-for-java-folder=<path to the root directory of your azure-sdk-for-java clone>`.

``` yaml $(tag) == 'package-2015-07-01' && $(java) && $(multiapi)
java:
  namespace: com.microsoft.azure.management.authorization.v2015_07_01
  output-folder: $(azure-libraries-for-java-folder)/sdk/authorization/mgmt-v2015_07_01
regenerate-manager: true
generate-interface: true
```

### Tag: package-2015-06-01-preview and java

These settings apply only when `--tag=package-2015-06-01-preview --java` is specified on he command line.
Please also specify `--azure-libraries-for-java-folder=<path to the root directory of your azure-sdk-for-java clone>`.

``` yaml $(tag) == 'package-2015-06-01-preview' && $(java) && $(multiapi)
java:
  namespace: com.microsoft.azure.management.authorization.v2015_06_01
  output-folder: $(azure-libraries-for-java-folder)/sdk/authorization/mgmt-v2015_06_01
regenerate-manager: true
generate-interface: true
```

### Tag: package-2021-01-01-preview-only and java

These settings apply only when `--tag=package-2021-01-01-preview-only --java` is specified on he command line.
Please also specify `--azure-libraries-for-java-folder=<path to the root directory of your azure-sdk-for-java clone>`.

``` yaml $(tag) == 'package-2021-01-01-preview-only' && $(java) && $(multiapi)
java:
  namespace: com.microsoft.azure.management.authorization.v2021_01_01_preview
  output-folder: $(azure-libraries-for-java-folder)/sdk/authorization/mgmt-v2021_01_01_preview
regenerate-manager: true
generate-interface: true
```

### Tag: package-2020-10-01-preview and java

These settings apply only when `--tag=package-2020-10-01-preview --java` is specified on he command line.
Please also specify `--azure-libraries-for-java-folder=<path to the root directory of your azure-sdk-for-java clone>`.

``` yaml $(tag) == 'package-2020-10-01-preview' && $(java) && $(multiapi)
java:
  namespace: com.microsoft.azure.management.authorization.v2020_10_01_preview
  output-folder: $(azure-libraries-for-java-folder)/sdk/authorization/mgmt-v2020_10_01_preview
regenerate-manager: true
generate-interface: true
```

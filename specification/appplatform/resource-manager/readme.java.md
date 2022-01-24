## Java

These settings apply only when `--java` is specified on the command line.
Please also specify `--azure-libraries-for-java-folder=<path to the root directory of your azure-libraries-for-java clone>`.

``` yaml $(java)
azure-arm: true
fluent: true
namespace: com.microsoft.azure.management.appplatform
license-header: MICROSOFT_MIT_NO_CODEGEN
payload-flattening-threshold: 1
output-folder: $(azure-libraries-for-java-folder)/azure-mgmt-appplatform
```

### Java multi-api

``` yaml $(java) && $(multiapi)
batch:
  - tag: package-preview-2022-01
  - tag: package-preview-2021-09
  - tag: package-preview-2021-06
  - tag: package-preview-2020-11
  - tag: package-2020-07
  - tag: package-2019-05-01-preview
```

### Tag: package-preview-2022-01 and java

These settings apply only when `--tag=package-preview-2022-01 --java` is specified on the command line.
Please also specify `--azure-libraries-for-java-folder=<path to the root directory of your azure-sdk-for-java clone>`.

``` yaml $(tag) == 'package-preview-2022-01' && $(java) && $(multiapi)
java:
  namespace: com.microsoft.azure.management.appplatform.v2022_01_01_preview
  output-folder: $(azure-libraries-for-java-folder)/sdk/appplatform/mgmt-v2022_01_01_preview
regenerate-manager: true
generate-interface: true
```

### Tag: package-preview-2021-09 and java

These settings apply only when `--tag=package-preview-2021-09 --java` is specified on the command line.
Please also specify `--azure-libraries-for-java-folder=<path to the root directory of your azure-sdk-for-java clone>`.

``` yaml $(tag) == 'package-preview-2021-09' && $(java) && $(multiapi)
java:
  namespace: com.microsoft.azure.management.appplatform.v2021_09_01_preview
  output-folder: $(azure-libraries-for-java-folder)/sdk/appplatform/mgmt-v2021_09_01_preview
regenerate-manager: true
generate-interface: true
```

### Tag: package-preview-2021-06 and java

These settings apply only when `--tag=package-preview-2021-06 --java` is specified on the command line.
Please also specify `--azure-libraries-for-java-folder=<path to the root directory of your azure-sdk-for-java clone>`.

``` yaml $(tag) == 'package-preview-2021-06' && $(java) && $(multiapi)
java:
  namespace: com.microsoft.azure.management.appplatform.v2021_06_01_preview
  output-folder: $(azure-libraries-for-java-folder)/sdk/appplatform/mgmt-v2021_06_01_preview
regenerate-manager: true
generate-interface: true
```

### Tag: package-preview-2020-11 and java

These settings apply only when `--tag=package-preview-2020-11 --java` is specified on the command line.
Please also specify `--azure-libraries-for-java-folder=<path to the root directory of your azure-sdk-for-java clone>`.

``` yaml $(tag) == 'package-preview-2020-11' && $(java) && $(multiapi)
java:
  namespace: com.microsoft.azure.management.appplatform.v2020_11_01_preview
  output-folder: $(azure-libraries-for-java-folder)/sdk/appplatform/mgmt-v2020_11_01_preview
regenerate-manager: true
generate-interface: true
```

### Tag: package-2020-07 and java

These settings apply only when `--tag=package-2020-07 --java` is specified on the command line.
Please also specify `--azure-libraries-for-java-folder=<path to the root directory of your azure-sdk-for-java clone>`.

``` yaml $(tag) == 'package-2020-07' && $(java) && $(multiapi)
java:
  namespace: com.microsoft.azure.management.appplatform.v2020_07_01
  output-folder: $(azure-libraries-for-java-folder)/sdk/appplatform/mgmt-v2020_07_01
regenerate-manager: true
generate-interface: true
```

### Tag: package-2019-05-01-preview and java

These settings apply only when `--tag=package-2019-05-01-preview --java` is specified on the command line.
Please also specify `--azure-libraries-for-java-folder=<path to the root directory of your azure-sdk-for-java clone>`.

``` yaml $(tag) == 'package-2019-05-01-preview' && $(java) && $(multiapi)
java:
  namespace: com.microsoft.azure.management.appplatform.v2019_05_01_preview
  output-folder: $(azure-libraries-for-java-folder)/sdk/appplatform/mgmt-v2019_05_01_preview
regenerate-manager: true
generate-interface: true
```

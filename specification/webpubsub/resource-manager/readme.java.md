## Java

These settings apply only when `--java` is specified on the command line.
Please also specify `--azure-libraries-for-java-folder=<path to the root directory of your azure-libraries-for-java clone>`.

``` yaml $(java)
azure-arm: true
fluent: true
namespace: com.microsoft.azure.management.webpubsub
license-header: MICROSOFT_MIT_NO_CODEGEN
payload-flattening-threshold: 1
output-folder: $(azure-libraries-for-java-folder)/azure-mgmt-webpubsub
```

### Java multi-api

``` yaml $(java) && $(multiapi)
batch:
  - tag: package-2021-04-01-preview
  - tag: package-2021-06-01-preview
  - tag: package-2021-09-01-preview
  - tag: package-2022-08-01-preview
  - tag: package-2021-10-01
  - tag: package-2023-02-01
  - tag: package-2023-03-01-preview
  - tag: package-2023-06-01-preview
  - tag: package-2023-08-01-preview
```

### Tag: package-2021-04-01-preview and java

These settings apply only when `--tag=package-2021-04-01-preview --java` is specified on the command line.
Please also specify `--azure-libraries-for-java-folder=<path to the root directory of your azure-sdk-for-java clone>`.

``` yaml $(tag) == 'package-2021-04-01-preview' && $(java) && $(multiapi)
java:
  namespace: com.microsoft.azure.management.webpubsub.v2021_04_01_preview
  output-folder: $(azure-libraries-for-java-folder)/sdk/webpubsub/mgmt-v2021_04_01_preview
regenerate-manager: true
generate-interface: true
```

### Tag: package-2021-06-01-preview and java

These settings apply only when `--tag=package-2021-06-01-preview --java` is specified on the command line.
Please also specify `--azure-libraries-for-java-folder=<path to the root directory of your azure-sdk-for-java clone>`.

``` yaml $(tag) == 'package-2021-06-01-preview' && $(java) && $(multiapi)
java:
  namespace: com.microsoft.azure.management.webpubsub.v2021_06_01_preview
  output-folder: $(azure-libraries-for-java-folder)/sdk/webpubsub/mgmt-v2021_06_01_preview
regenerate-manager: true
generate-interface: true
```

### Tag: package-2021-09-01-preview and java

These settings apply only when `--tag=package-2021-09-01-preview --java` is specified on the command line.
Please also specify `--azure-libraries-for-java-folder=<path to the root directory of your azure-sdk-for-java clone>`.

``` yaml $(tag) == 'package-2021-09-01-preview' && $(java) && $(multiapi)
java:
  namespace: com.microsoft.azure.management.webpubsub.v2021_09_01_preview
  output-folder: $(azure-libraries-for-java-folder)/sdk/webpubsub/mgmt-v2021_09_01_preview
regenerate-manager: true
generate-interface: true
```

### Tag: package-2022-08-01-preview and java

These settings apply only when `--tag=package-2022-08-01-preview --java` is specified on the command line.
Please also specify `--azure-libraries-for-java-folder=<path to the root directory of your azure-sdk-for-java clone>`.

``` yaml $(tag) == 'package-2022-08-01-preview' && $(java) && $(multiapi)
java:
  namespace: com.microsoft.azure.management.webpubsub.v2022_08_01_preview
  output-folder: $(azure-libraries-for-java-folder)/sdk/webpubsub/mgmt-v2022_08_01_preview
regenerate-manager: true
generate-interface: true
```

### Tag: package-2021-10-01 and java

These settings apply only when `--tag=package-2021-10-01 --java` is specified on the command line.
Please also specify `--azure-libraries-for-java-folder=<path to the root directory of your azure-sdk-for-java clone>`.

``` yaml $(tag) == 'package-2021-10-01' && $(java) && $(multiapi)
java:
  namespace: com.microsoft.azure.management.webpubsub.v2021_10_01
  output-folder: $(azure-libraries-for-java-folder)/sdk/webpubsub/mgmt-v2021_10_01
regenerate-manager: true
generate-interface: true
```

### Tag: package-2023-02-01 and java

These settings apply only when `--tag=package-2023-02-01 --java` is specified on the command line.
Please also specify `--azure-libraries-for-java-folder=<path to the root directory of your azure-sdk-for-java clone>`.

``` yaml $(tag) == 'package-2023-02-01' && $(java) && $(multiapi)
java:
  namespace: com.microsoft.azure.management.webpubsub.v2023_02_01
  output-folder: $(azure-libraries-for-java-folder)/sdk/webpubsub/mgmt-v2023_02_01
regenerate-manager: true
generate-interface: true
```

### Tag: package-2023-03-01-preview and java

These settings apply only when `--tag=package-2023-03-01-preview --java` is specified on the command line.
Please also specify `--azure-libraries-for-java-folder=<path to the root directory of your azure-sdk-for-java clone>`.

``` yaml $(tag) == 'package-2023-03-01-preview' && $(java) && $(multiapi)
java:
  namespace: com.microsoft.azure.management.webpubsub.v2023_03_01_preview
  output-folder: $(azure-libraries-for-java-folder)/sdk/webpubsub/mgmt-v2023_03_01_preview
regenerate-manager: true
generate-interface: true
```

### Tag: package-2023-06-01-preview and java

These settings apply only when `--tag=package-2023-06-01-preview --java` is specified on the command line.
Please also specify `--azure-libraries-for-java-folder=<path to the root directory of your azure-sdk-for-java clone>`.

``` yaml $(tag) == 'package-2023-06-01-preview' && $(java) && $(multiapi)
java:
  namespace: com.microsoft.azure.management.webpubsub.v2023_06_01_preview
  output-folder: $(azure-libraries-for-java-folder)/sdk/webpubsub/mgmt-v2023_06_01_preview
regenerate-manager: true
generate-interface: true
```

### Tag: package-2023-08-01-preview and java

These settings apply only when `--tag=package-2023-08-01-preview --java` is specified on the command line.
Please also specify `--azure-libraries-for-java-folder=<path to the root directory of your azure-sdk-for-java clone>`.

``` yaml $(tag) == 'package-2023-08-01-preview' && $(java) && $(multiapi)
java:
  namespace: com.microsoft.azure.management.webpubsub.v2023_08_01_preview
  output-folder: $(azure-libraries-for-java-folder)/sdk/webpubsub/mgmt-v2023_08_01_preview
regenerate-manager: true
generate-interface: true
```
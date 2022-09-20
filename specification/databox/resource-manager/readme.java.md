## Java

These settings apply only when `--java` is specified on the command line.
Please also specify `--azure-libraries-for-java-folder=<path to the root directory of your azure-libraries-for-java clone>`.

``` yaml $(java)
java:
  azure-arm: true
  fluent: true
  namespace: com.microsoft.azure.management.databox
  license-header: MICROSOFT_MIT_NO_CODEGEN
  payload-flattening-threshold: 1
  output-folder: $(azure-libraries-for-java-folder)/azure-mgmt-databox
```

### Java multi-api

``` yaml $(java) && $(multiapi)
batch:
  - tag: package-2018-01
  - tag: package-2019-09
  - tag: package-2020-04
  - tag: package-2020-11
  - tag: package-2021-03
  - tag: package-2021-05
  - tag: package-2021-08-preview
  - tag: package-2021-12
  - tag: package-2022-02
```

### Tag: package-2018-01 and java

These settings apply only when `--tag=package-2018-01 --java` is specified on the command line.
Please also specify `--azure-libraries-for-java-folder=<path to the root directory of your azure-sdk-for-java clone>`.

``` yaml $(tag) == 'package-2018-01' && $(java) && $(multiapi)
java:
  namespace: com.microsoft.azure.management.databox.v2018_01_01
  output-folder: $(azure-libraries-for-java-folder)/sdk/databox/mgmt-v2018_01_01
regenerate-manager: true
generate-interface: true
```

### Tag: package-2019-09 and java

These settings apply only when `--tag=package-2019-09-java` is specified on the command line.
Please also specify `--azure-libraries-for-java-folder=<path to the root directory of your azure-sdk-for-java clone>`.

``` yaml $(tag) == 'package-2019-09' && $(java) && $(multiapi)
java:
  namespace: com.microsoft.azure.management.databox.v2019_09-01
  output-folder: $(azure-libraries-for-java-folder)/sdk/databox/mgmt-v2019_09_01
regenerate-manager: true
generate-interface: true
```

### Tag: package-2020-04 and java

These settings apply only when `--tag=package-2020-04-java` is specified on the command line.
Please also specify `--azure-libraries-for-java-folder=<path to the root directory of your azure-sdk-for-java clone>`.

``` yaml $(tag) == 'package-2020-04' && $(java) && $(multiapi)
java:
  namespace: com.microsoft.azure.management.databox.v2020_04-01
  output-folder: $(azure-libraries-for-java-folder)/sdk/databox/mgmt-v2020_04_01
regenerate-manager: true
generate-interface: true
```

### Tag: package-2020-11 and java

These settings apply only when `--tag=package-2020-11-java` is specified on the command line.
Please also specify `--azure-libraries-for-java-folder=<path to the root directory of your azure-sdk-for-java clone>`.

``` yaml $(tag) == 'package-2020-11' && $(java) && $(multiapi)
java:
  namespace: com.microsoft.azure.management.databox.v2020_11-01
  output-folder: $(azure-libraries-for-java-folder)/sdk/databox/mgmt-v2020_11_01
regenerate-manager: true
generate-interface: true
```

### Tag: package-2021-03 and java

These settings apply only when `--tag=package-2021-03-java` is specified on the command line.
Please also specify `--azure-libraries-for-java-folder=<path to the root directory of your azure-sdk-for-java clone>`.

``` yaml $(tag) == 'package-2021-03' && $(java) && $(multiapi)
java:
  namespace: com.microsoft.azure.management.databox.v2021_03-01
  output-folder: $(azure-libraries-for-java-folder)/sdk/databox/mgmt-v2021_03_01
regenerate-manager: true
generate-interface: true
```

### Tag: package-2021-05 and java

These settings apply only when `--tag=package-2021-05-java` is specified on the command line.
Please also specify `--azure-libraries-for-java-folder=<path to the root directory of your azure-sdk-for-java clone>`.

``` yaml $(tag) == 'package-2021-05' && $(java) && $(multiapi)
java:
  namespace: com.microsoft.azure.management.databox.v2021_05-01
  output-folder: $(azure-libraries-for-java-folder)/sdk/databox/mgmt-v2021_05_01
regenerate-manager: true
generate-interface: true
```

### Tag: package-2021-08-preview and java

These settings apply only when `--tag=package-2021-08-preview-java` is specified on the command line.
Please also specify `--azure-libraries-for-java-folder=<path to the root directory of your azure-sdk-for-java clone>`.

``` yaml $(tag) == 'package-2021-08-preview' && $(java) && $(multiapi)
java:
  namespace: com.microsoft.azure.management.databox.v2021_08-01-preview
  output-folder: $(azure-libraries-for-java-folder)/sdk/databox/mgmt-v2021_08_01_preview
regenerate-manager: true
generate-interface: true
```

### Tag: package-2021-12 and java

These settings apply only when `--tag=package-2021-12-java` is specified on the command line.
Please also specify `--azure-libraries-for-java-folder=<path to the root directory of your azure-sdk-for-java clone>`.

``` yaml $(tag) == 'package-2021-12' && $(java) && $(multiapi)
java:
  namespace: com.microsoft.azure.management.databox.v2021_12-01
  output-folder: $(azure-libraries-for-java-folder)/sdk/databox/mgmt-v2021_12_01
regenerate-manager: true
generate-interface: true
```

### Tag: package-2022-02 and java

These settings apply only when `--tag=package-2022-02-java` is specified on the command line.
Please also specify `--azure-libraries-for-java-folder=<path to the root directory of your azure-sdk-for-java clone>`.

``` yaml $(tag) == 'package-2022-02' && $(java) && $(multiapi)
java:
  namespace: com.microsoft.azure.management.databox.v2022_02-01
  output-folder: $(azure-libraries-for-java-folder)/sdk/databox/mgmt-v2022_02_01
regenerate-manager: true
generate-interface: true
```
## Java

These settings apply only when `--java` is specified on the command line.
Please also specify `--azure-libraries-for-java-folder=<path to the root directory of your azure-libraries-for-java clone>`.

``` yaml $(java)
azure-arm: true
fluent: true
namespace: com.microsoft.azure.management.signalr
license-header: MICROSOFT_MIT_NO_CODEGEN
payload-flattening-threshold: 1
output-folder: $(azure-libraries-for-java-folder)/azure-mgmt-signalr
```

### Java multi-api

``` yaml $(java) && $(multiapi)
batch:
  - tag: package-2018-03-01-preview
  - tag: package-2018-10-01
  - tag: package-2020-05-01
  - tag: package-2020-07-01-preview
  - tag: package-2021-04-01-preview
  - tag: package-2021-06-01-preview
  - tag: package-2021-09-01-preview
  - tag: package-2021-10-01
  - tag: package-2022-02-01
  - tag: package-2022-08-01-preview
  - tag: package-2023-02-01
  - tag: package-2023-03-01-preview
  - tag: package-2023-06-01-preview
  - tag: package-2023-08-01-preview
  - tag: package-2024-01-01-preview 
  - tag: package-2024-03-01 
  - tag: package-2024-04-01-preview 
  - tag: package-2024-08-01-preview 
```

### Tag: package-2024-08-01-preview and java

These settings apply only when `--tag=package-2024-08-01-preview --java` is specified on the command line.
Please also specify `--azure-libraries-for-java-folder=<path to the root directory of your azure-sdk-for-java clone>`.

``` yaml $(tag) == 'package-2024-08-01-preview' && $(java) && $(multiapi)
java:
  namespace: com.microsoft.azure.management.signalr.v2024_08_01_preview
  output-folder: $(azure-libraries-for-java-folder)/sdk/signalr/mgmt-v2024_08_01_preview
regenerate-manager: true
generate-interface: true
```

### Tag: package-2024-04-01-preview and java

These settings apply only when `--tag=package-2024-04-01-preview --java` is specified on the command line.
Please also specify `--azure-libraries-for-java-folder=<path to the root directory of your azure-sdk-for-java clone>`.

``` yaml $(tag) == 'package-2024-04-01-preview' && $(java) && $(multiapi)
java:
  namespace: com.microsoft.azure.management.signalr.v2024_04_01_preview
  output-folder: $(azure-libraries-for-java-folder)/sdk/signalr/mgmt-v2024_04_01_preview
regenerate-manager: true
generate-interface: true
```

### Tag: package-2024-03-01 and java

These settings apply only when `--tag=package-2024-03-01 --java` is specified on the command line.
Please also specify `--azure-libraries-for-java-folder=<path to the root directory of your azure-sdk-for-java clone>`.

``` yaml $(tag) == 'package-2024-03-01' && $(java) && $(multiapi)
java:
  namespace: com.microsoft.azure.management.signalr.v2024_03_01
  output-folder: $(azure-libraries-for-java-folder)/sdk/signalr/mgmt-v2024_03_01
regenerate-manager: true
generate-interface: true
```

### Tag: package-2024-01-01-preview and java

These settings apply only when `--tag=package-2024-01-01-preview --java` is specified on the command line.
Please also specify `--azure-libraries-for-java-folder=<path to the root directory of your azure-sdk-for-java clone>`.

``` yaml $(tag) == 'package-2024-01-01-preview' && $(java) && $(multiapi)
java:
  namespace: com.microsoft.azure.management.signalr.v2024_01_01_preview
  output-folder: $(azure-libraries-for-java-folder)/sdk/signalr/mgmt-v2024_01_01_preview
regenerate-manager: true
generate-interface: true
```

### Tag: package-2023-08-01-preview and java

These settings apply only when `--tag=package-2023-08-01-preview --java` is specified on the command line.
Please also specify `--azure-libraries-for-java-folder=<path to the root directory of your azure-sdk-for-java clone>`.

``` yaml $(tag) == 'package-2023-08-01-preview' && $(java) && $(multiapi)
java:
  namespace: com.microsoft.azure.management.signalr.v2023_08_01_preview
  output-folder: $(azure-libraries-for-java-folder)/sdk/signalr/mgmt-v2023_08_01_preview
regenerate-manager: true
generate-interface: true
```

### Tag: package-2023-06-01-preview and java

These settings apply only when `--tag=package-2023-06-01-preview --java` is specified on the command line.
Please also specify `--azure-libraries-for-java-folder=<path to the root directory of your azure-sdk-for-java clone>`.

``` yaml $(tag) == 'package-2023-06-01-preview' && $(java) && $(multiapi)
java:
  namespace: com.microsoft.azure.management.signalr.v2023_06_01_preview
  output-folder: $(azure-libraries-for-java-folder)/sdk/signalr/mgmt-v2023_06_01_preview
regenerate-manager: true
generate-interface: true
```

### Tag: package-2023-03-01-preview and java

These settings apply only when `--tag=package-2023-03-01-preview --java` is specified on the command line.
Please also specify `--azure-libraries-for-java-folder=<path to the root directory of your azure-sdk-for-java clone>`.

``` yaml $(tag) == 'package-2023-03-01-preview' && $(java) && $(multiapi)
java:
  namespace: com.microsoft.azure.management.signalr.v2023_03_01_preview
  output-folder: $(azure-libraries-for-java-folder)/sdk/signalr/mgmt-v2023_03_01_preview
regenerate-manager: true
generate-interface: true
```

### Tag: package-2023-02-01 and java

These settings apply only when `--tag=package-2023-02-01 --java` is specified on the command line.
Please also specify `--azure-libraries-for-java-folder=<path to the root directory of your azure-sdk-for-java clone>`.

``` yaml $(tag) == 'package-2023-02-01' && $(java) && $(multiapi)
java:
  namespace: com.microsoft.azure.management.signalr.v2023_02_01
  output-folder: $(azure-libraries-for-java-folder)/sdk/signalr/mgmt-v2023_02_01
regenerate-manager: true
generate-interface: true
```

### Tag: package-2022-08-01-preview and java

These settings apply only when `--tag=package-2022-08-01-preview --java` is specified on the command line.
Please also specify `--azure-libraries-for-java-folder=<path to the root directory of your azure-sdk-for-java clone>`.

``` yaml $(tag) == 'package-2022-08-01-preview' && $(java) && $(multiapi)
java:
  namespace: com.microsoft.azure.management.signalr.v2022_08_01_preview
  output-folder: $(azure-libraries-for-java-folder)/sdk/signalr/mgmt-v2022_08_01_preview
regenerate-manager: true
generate-interface: true
```

### Tag: package-2022-02-01 and java

These settings apply only when `--tag=package-2022-02-01 --java` is specified on the command line.
Please also specify `--azure-libraries-for-java-folder=<path to the root directory of your azure-sdk-for-java clone>`.

``` yaml $(tag) == 'package-2022-02-01' && $(java) && $(multiapi)
java:
  namespace: com.microsoft.azure.management.signalr.v2022_02_01
  output-folder: $(azure-libraries-for-java-folder)/sdk/signalr/mgmt-v2022_02_01
regenerate-manager: true
generate-interface: true
```

### Tag: package-2021-10-01 and java

These settings apply only when `--tag=package-2021-10-01 --java` is specified on the command line.
Please also specify `--azure-libraries-for-java-folder=<path to the root directory of your azure-sdk-for-java clone>`.

``` yaml $(tag) == 'package-2021-10-01' && $(java) && $(multiapi)
java:
  namespace: com.microsoft.azure.management.signalr.v2021_10_01
  output-folder: $(azure-libraries-for-java-folder)/sdk/signalr/mgmt-v2021_10_01
regenerate-manager: true
generate-interface: true
```

### Tag: package-2021-09-01-preview and java

These settings apply only when `--tag=package-2021-09-01-preview --java` is specified on the command line.
Please also specify `--azure-libraries-for-java-folder=<path to the root directory of your azure-sdk-for-java clone>`.

``` yaml $(tag) == 'package-2021-09-01-preview' && $(java) && $(multiapi)
java:
  namespace: com.microsoft.azure.management.signalr.v2021_09_01_preview
  output-folder: $(azure-libraries-for-java-folder)/sdk/signalr/mgmt-v2021_09_01_preview
regenerate-manager: true
generate-interface: true
```

### Tag: package-2021-06-01-preview and java

These settings apply only when `--tag=package-2021-06-01-preview --java` is specified on the command line.
Please also specify `--azure-libraries-for-java-folder=<path to the root directory of your azure-sdk-for-java clone>`.

``` yaml $(tag) == 'package-2021-06-01-preview' && $(java) && $(multiapi)
java:
  namespace: com.microsoft.azure.management.signalr.v2021_06_01_preview
  output-folder: $(azure-libraries-for-java-folder)/sdk/signalr/mgmt-v2021_06_01_preview
regenerate-manager: true
generate-interface: true
```


### Tag: package-2021-04-01-preview and java

These settings apply only when `--tag=package-2021-04-01-preview --java` is specified on the command line.
Please also specify `--azure-libraries-for-java-folder=<path to the root directory of your azure-sdk-for-java clone>`.

``` yaml $(tag) == 'package-2021-04-01-preview' && $(java) && $(multiapi)
java:
  namespace: com.microsoft.azure.management.signalr.v2021_04_01_preview
  output-folder: $(azure-libraries-for-java-folder)/sdk/signalr/mgmt-v2021_04_01_preview
regenerate-manager: true
generate-interface: true
```

### Tag: package-2020-07-01-preview and java

These settings apply only when `--tag=package-2020-07-01-preview --java` is specified on the command line.
Please also specify `--azure-libraries-for-java-folder=<path to the root directory of your azure-sdk-for-java clone>`.

``` yaml $(tag) == 'package-2020-07-01-preview' && $(java) && $(multiapi)
java:
  namespace: com.microsoft.azure.management.signalr.v2020_07_01_preview
  output-folder: $(azure-libraries-for-java-folder)/sdk/signalr/mgmt-v2020_07_01_preview
regenerate-manager: true
generate-interface: true
```

### Tag: package-2020-05-01 and java

These settings apply only when `--tag=package-2020-05-01 --java` is specified on the command line.
Please also specify `--azure-libraries-for-java-folder=<path to the root directory of your azure-sdk-for-java clone>`.

``` yaml $(tag) == 'package-2020-05-01' && $(java) && $(multiapi)
java:
  namespace: com.microsoft.azure.management.signalr.v2020_05_01
  output-folder: $(azure-libraries-for-java-folder)/sdk/signalr/mgmt-v2020_05_01
regenerate-manager: true
generate-interface: true
```

### Tag: package-2018-10-01 and java

These settings apply only when `--tag=package-2018-10-01 --java` is specified on the command line.
Please also specify `--azure-libraries-for-java-folder=<path to the root directory of your azure-sdk-for-java clone>`.

``` yaml $(tag) == 'package-2018-10-01' && $(java) && $(multiapi)
java:
  namespace: com.microsoft.azure.management.signalr.v2018_10_01
  output-folder: $(azure-libraries-for-java-folder)/sdk/signalr/mgmt-v2018_10_01
regenerate-manager: true
generate-interface: true
```

### Tag: package-2018-03-01-preview and java

These settings apply only when `--tag=package-2018-03-01-preview --java` is specified on the command line.
Please also specify `--azure-libraries-for-java-folder=<path to the root directory of your azure-sdk-for-java clone>`.

``` yaml $(tag) == 'package-2018-03-01-preview' && $(java) && $(multiapi)
java:
  namespace: com.microsoft.azure.management.signalr.v2018_03_01_preview
  output-folder: $(azure-libraries-for-java-folder)/sdk/signalr/mgmt-v2018_03_01_preview
regenerate-manager: true
generate-interface: true
```

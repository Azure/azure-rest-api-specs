## Java

These settings apply only when `--java` is specified on the command line.
Please also specify `--azure-libraries-for-java-folder=<path to the root directory of your azure-libraries-for-java clone>`.

``` yaml $(java)
azure-arm: true
fluent: true
namespace: com.microsoft.azure.management.machinelearning.services
license-header: MICROSOFT_MIT_NO_CODEGEN
payload-flattening-threshold: 1
output-folder: $(azure-libraries-for-java-folder)/azure-mgmt-machinelearning/services

service-name: MachineLearningServices
```

### Java multi-api

``` yaml $(java) && $(multiapi)
batch:
  - tag: package-2022-01-01-preview
  - tag: package-2021-07-01
  - tag: package-2021-03-01-preview
  - tag: package-2021-04-01
  - tag: package-2021-01-01
  - tag: package-2020-08-01
  - tag: package-2020-06-01
  - tag: package-2020-04-01
  - tag: package-2020-03-01
  - tag: package-2020-01-01
  - tag: package-2019-11-01
  - tag: package-2019-06-01
  - tag: package-2019-05-01
  - tag: package-2018-11-19
  - tag: package-2020-09-01-preview
  - tag: package-2020-05-01-preview
  - tag: package-2020-04-01-preview
  - tag: package-2020-02-18-preview
  - tag: package-2018-03-preview
```

### Tag: package-2022-01-01-preview and java

These settings apply only when `--tag=package-2022-01-01-preview --java` is specified on the command line.
Please also specify `--azure-libraries-for-java=<path to the root directory of your azure-sdk-for-java clone>`.

``` yaml $(tag) == 'package-2022-01-01-preview' && $(java) && $(multiapi)
java:
  namespace: com.microsoft.azure.management.machinelearningservices.v2022_01_01_preview
  output-folder: $(azure-libraries-for-java-folder)/sdk/machinelearningservices/mgmt-v2022_01_01_preview
regenerate-manager: true
generate-interface: true
```

### Tag: package-2021-07-01 and java

These settings apply only when `--tag=package-2021-07-01 --java` is specified on the command line.
Please also specify `--azure-libraries-for-java=<path to the root directory of your azure-sdk-for-java clone>`.

``` yaml $(tag) == 'package-2021-07-01' && $(java) && $(multiapi)
java:
  namespace: com.microsoft.azure.management.machinelearningservices.v2021_07_01
  output-folder: $(azure-libraries-for-java-folder)/sdk/machinelearningservices/mgmt-v2021_07_01
regenerate-manager: true
generate-interface: true
```

### Tag: package-2021-03-01-preview and java

These settings apply only when `--tag=package-2021-03-01-preview --java` is specified on the command line.
Please also specify `--azure-libraries-for-java=<path to the root directory of your azure-sdk-for-java clone>`.

``` yaml $(tag) == 'package-2021-03-01-preview' && $(java) && $(multiapi)
java:
  namespace: com.microsoft.azure.management.machinelearningservices.v2021_03_01_preview
  output-folder: $(azure-libraries-for-java-folder)/sdk/machinelearningservices/mgmt-v2021_03_01_preview
regenerate-manager: true
generate-interface: true
```

### Tag: package-2021-04-01 and java

These settings apply only when `--tag=package-2021-04-01 --java` is specified on the command line.
Please also specify `--azure-libraries-for-java=<path to the root directory of your azure-sdk-for-java clone>`.

``` yaml $(tag) == 'package-2021-04-01' && $(java) && $(multiapi)
java:
  namespace: com.microsoft.azure.management.machinelearningservices.v2021_04_01
  output-folder: $(azure-libraries-for-java-folder)/sdk/machinelearningservices/mgmt-v2021_04_01
regenerate-manager: true
generate-interface: true
```

### Tag: package-2021-01-01 and java

These settings apply only when `--tag=package-2021-01-01 --java` is specified on the command line.
Please also specify `--azure-libraries-for-java=<path to the root directory of your azure-sdk-for-java clone>`.

``` yaml $(tag) == 'package-2021-01-01' && $(java) && $(multiapi)
java:
  namespace: com.microsoft.azure.management.machinelearningservices.v2021_01_01
  output-folder: $(azure-libraries-for-java-folder)/sdk/machinelearningservices/mgmt-v2021_01_01
regenerate-manager: true
generate-interface: true
```

### Tag: package-2020-08-01 and java

These settings apply only when `--tag=package-2020-08-01 --java` is specified on the command line.
Please also specify `--azure-libraries-for-java=<path to the root directory of your azure-sdk-for-java clone>`.

``` yaml $(tag) == 'package-2020-08-01' && $(java) && $(multiapi)
java:
  namespace: com.microsoft.azure.management.machinelearningservices.v2020_08_01
  output-folder: $(azure-libraries-for-java-folder)/sdk/machinelearningservices/mgmt-v2020_08_01
regenerate-manager: true
generate-interface: true
```

### Tag: package-2020-06-01 and java

These settings apply only when `--tag=package-2020-06-01 --java` is specified on the command line.
Please also specify `--azure-libraries-for-java=<path to the root directory of your azure-sdk-for-java clone>`.

``` yaml $(tag) == 'package-2020-06-01' && $(java) && $(multiapi)
java:
  namespace: com.microsoft.azure.management.machinelearningservices.v2020_06_01
  output-folder: $(azure-libraries-for-java-folder)/sdk/machinelearningservices/mgmt-v2020_06_01
regenerate-manager: true
generate-interface: true
```

### Tag: package-2020-04-01 and java

These settings apply only when `--tag=package-2020-04-01 --java` is specified on the command line.
Please also specify `--azure-libraries-for-java=<path to the root directory of your azure-sdk-for-java clone>`.

``` yaml $(tag) == 'package-2020-04-01' && $(java) && $(multiapi)
java:
  namespace: com.microsoft.azure.management.machinelearningservices.v2020_04_01
  output-folder: $(azure-libraries-for-java-folder)/sdk/machinelearningservices/mgmt-v2020_04_01
regenerate-manager: true
generate-interface: true
```

### Tag: package-2020-03-01 and java

These settings apply only when `--tag=package-2020-03-01 --java` is specified on the command line.
Please also specify `--azure-libraries-for-java=<path to the root directory of your azure-sdk-for-java clone>`.

``` yaml $(tag) == 'package-2020-03-01' && $(java) && $(multiapi)
java:
  namespace: com.microsoft.azure.management.machinelearningservices.v2020_03_01
  output-folder: $(azure-libraries-for-java-folder)/sdk/machinelearningservices/mgmt-v2020_03_01
regenerate-manager: true
generate-interface: true
```

### Tag: package-2020-01-01 and java

These settings apply only when `--tag=package-2020-01-01 --java` is specified on the command line.
Please also specify `--azure-libraries-for-java=<path to the root directory of your azure-sdk-for-java clone>`.

``` yaml $(tag) == 'package-2020-01-01' && $(java) && $(multiapi)
java:
  namespace: com.microsoft.azure.management.machinelearningservices.v2020_01_01
  output-folder: $(azure-libraries-for-java-folder)/sdk/machinelearningservices/mgmt-v2020_01_01
regenerate-manager: true
generate-interface: true
```

### Tag: package-2019-11-01 and java

These settings apply only when `--tag=package-2019-11-01 --java` is specified on the command line.
Please also specify `--azure-libraries-for-java=<path to the root directory of your azure-sdk-for-java clone>`.

``` yaml $(tag) == 'package-2019-11-01' && $(java) && $(multiapi)
java:
  namespace: com.microsoft.azure.management.machinelearningservices.v2019_11_01
  output-folder: $(azure-libraries-for-java-folder)/sdk/machinelearningservices/mgmt-v2019_11_01
regenerate-manager: true
generate-interface: true
```

### Tag: package-2019-06-01 and java

These settings apply only when `--tag=package-2019-06-01 --java` is specified on the command line.
Please also specify `--azure-libraries-for-java=<path to the root directory of your azure-sdk-for-java clone>`.

``` yaml $(tag) == 'package-2019-06-01' && $(java) && $(multiapi)
java:
  namespace: com.microsoft.azure.management.machinelearningservices.v2019_06_01
  output-folder: $(azure-libraries-for-java-folder)/sdk/machinelearningservices/mgmt-v2019_06_01
regenerate-manager: true
generate-interface: true
```

### Tag: package-2019-05-01 and java

These settings apply only when `--tag=package-2019-05-01 --java` is specified on the command line.
Please also specify `--azure-libraries-for-java=<path to the root directory of your azure-sdk-for-java clone>`.

``` yaml $(tag) == 'package-2019-05-01' && $(java) && $(multiapi)
java:
  namespace: com.microsoft.azure.management.machinelearningservices.v2019_05_01
  output-folder: $(azure-libraries-for-java-folder)/sdk/machinelearningservices/mgmt-v2019_05_01
regenerate-manager: true
generate-interface: true
```

### Tag: package-2018-11-19 and java

These settings apply only when `--tag=package-2018-11-19 --java` is specified on the command line.
Please also specify `--azure-libraries-for-java=<path to the root directory of your azure-sdk-for-java clone>`.

``` yaml $(tag) == 'package-2018-11-19' && $(java) && $(multiapi)
java:
  namespace: com.microsoft.azure.management.machinelearningservices.v2018_11_19
  output-folder: $(azure-libraries-for-java-folder)/sdk/machinelearningservices/mgmt-v2018_11_19
regenerate-manager: true
generate-interface: true
```

### Tag: package-2020-09-01-preview and java

These settings apply only when `--tag=package-2020-09-01-preview --java` is specified on the command line.
Please also specify `--azure-libraries-for-java=<path to the root directory of your azure-sdk-for-java clone>`.

``` yaml $(tag) == 'package-2020-09-01-preview' && $(java) && $(multiapi)
java:
  namespace: com.microsoft.azure.management.machinelearningservices.v2020_09_01_preview
  output-folder: $(azure-libraries-for-java-folder)/sdk/machinelearningservices/mgmt-v2020_09_01_preview
regenerate-manager: true
generate-interface: true
```

### Tag: package-2020-05-01-preview and java

These settings apply only when `--tag=package-2020-05-01-preview --java` is specified on the command line.
Please also specify `--azure-libraries-for-java=<path to the root directory of your azure-sdk-for-java clone>`.

``` yaml $(tag) == 'package-2020-05-01-preview' && $(java) && $(multiapi)
java:
  namespace: com.microsoft.azure.management.machinelearningservices.v2020_05_01_preview
  output-folder: $(azure-libraries-for-java-folder)/sdk/machinelearningservices/mgmt-v2020_05_01_preview
regenerate-manager: true
generate-interface: true
```

### Tag: package-2020-04-01-preview and java

These settings apply only when `--tag=package-2020-04-01-preview --java` is specified on the command line.
Please also specify `--azure-libraries-for-java=<path to the root directory of your azure-sdk-for-java clone>`.

``` yaml $(tag) == 'package-2020-04-01-preview' && $(java) && $(multiapi)
java:
  namespace: com.microsoft.azure.management.machinelearningservices.v2020_04_01_preview
  output-folder: $(azure-libraries-for-java-folder)/sdk/machinelearningservices/mgmt-v2020_04_01_preview
regenerate-manager: true
generate-interface: true
```

### Tag: package-2018-03-preview and java

These settings apply only when `--tag=package-2018-03-preview --java` is specified on the command line.
Please also specify `--azure-libraries-for-java=<path to the root directory of your azure-sdk-for-java clone>`.

``` yaml $(tag) == 'package-2018-03-preview' && $(java) && $(multiapi)
java:
  namespace: com.microsoft.azure.management.machinelearningservices.v2018_03_01_preview
  output-folder: $(azure-libraries-for-java-folder)/sdk/machinelearningservices/mgmt-v2018_03_01_preview
regenerate-manager: true
generate-interface: true
```

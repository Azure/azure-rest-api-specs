## Java

These settings apply only when `--java` is specified on the command line.
Please also specify `--azure-libraries-for-java-folder=<path to the root directory of your azure-libraries-for-java clone>`.

``` yaml $(java)
azure-arm: true
fluent: true
namespace: com.azure.resourcemanager.migration.assessment
license-header: MICROSOFT_MIT_NO_CODEGEN
payload-flattening-threshold: 1
output-folder: $(azure-libraries-for-java-folder)/azure-mgmt-migrationassessment
```

### Tag: package-preview-2023-09 and java

These settings apply only when `--tag=package-preview-2023-09 --java` is specified on the command line.
Please also specify `--azure-libraries-for-java=<path to the root directory of your azure-sdk-for-java clone>`.

```yaml $(tag) == 'package-preview-2023-09' && $(java)
java:
  namespace: com.azure.resourcemanager.migration.assessment.v2023_09_09
  output-folder: $(azure-libraries-for-java-folder)/sdk/migrationassessment/mgmt-v2023_09_09
regenerate-manager: true
generate-interface: true
```

### Tag: package-preview-2023-05 and java

These settings apply only when `--tag=package-preview-2023-05 --java` is specified on the command line.
Please also specify `--azure-libraries-for-java=<path to the root directory of your azure-sdk-for-java clone>`.

```yaml $(tag) == 'package-preview-2023-05' && $(java)
java:
  namespace: com.azure.resourcemanager.migration.assessment.v2023_05_01
  output-folder: $(azure-libraries-for-java-folder)/sdk/migrationassessment/mgmt-v2023_05_01
regenerate-manager: true
generate-interface: true
```

### Tag: package-preview-2023-04 and java

These settings apply only when `--tag=package-preview-2023-04 --java` is specified on the command line.
Please also specify `--azure-libraries-for-java=<path to the root directory of your azure-sdk-for-java clone>`.

```yaml $(tag) == 'package-preview-2023-04' && $(java)
java:
  namespace: com.azure.resourcemanager.migration.assessment.v2023_04_01
  output-folder: $(azure-libraries-for-java-folder)/sdk/migrationassessment/mgmt-v2023_04_01
regenerate-manager: true
generate-interface: true
```

### Tag: package-2023-03 and java

These settings apply only when `--tag=package-package-2023-03 --java` is specified on the command line.
Please also specify `--azure-libraries-for-java=<path to the root directory of your azure-sdk-for-java clone>`.

```yaml $(tag) == 'package-2023-03' && $(java)
java:
  namespace: com.azure.resourcemanager.migration.assessment.v2023_03_15
  output-folder: $(azure-libraries-for-java-folder)/sdk/migrationassessment/mgmt-v2023_03_15
regenerate-manager: true
generate-interface: true
```

### Tag: package-2019-10 and java

These settings apply only when `--tag=package-2019-10 --java` is specified on the command line.
Please also specify `--azure-libraries-for-java=<path to the root directory of your azure-sdk-for-java clone>`.

``` yaml $(tag) == 'package-2019-10' && $(java)
java:
  namespace: com.azure.resourcemanager.migration.assessment.v2019_10_01
  output-folder: $(azure-libraries-for-java-folder)/sdk/migrationassessment/mgmt-v2019_10_01
regenerate-manager: true
generate-interface: true
```

### Tag: package-2018-02 and java

These settings apply only when `--tag=package-2018-02 --java` is specified on the command line.
Please also specify `--azure-libraries-for-java=<path to the root directory of your azure-sdk-for-java clone>`.

``` yaml $(tag) == 'package-2018-02' && $(java)
java:
  namespace: com.azure.resourcemanager.migration.assessment.v2018_02_02
  output-folder: $(azure-libraries-for-java-folder)/sdk/migrationassessment/mgmt-v2018_02_02
regenerate-manager: true
generate-interface: true
```

### Tag: package-preview-2017-11 and java

These settings apply only when `--tag=package-preview-2017-11 --java` is specified on the command line.
Please also specify `--azure-libraries-for-java=<path to the root directory of your azure-sdk-for-java clone>`.

``` yaml $(tag) == 'package-preview-2017-11' && $(java)
java:
  namespace: com.azure.resourcemanager.migration.assessment.v2017_11_11
  output-folder: $(azure-libraries-for-java-folder)/sdk/migrationassessment/mgmt-v2017_11_11
regenerate-manager: true
generate-interface: true
```
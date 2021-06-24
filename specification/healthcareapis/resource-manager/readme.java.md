## Java

These settings apply only when `--java` is specified on the command line.
Please also specify `--azure-libraries-for-java-folder=<path to the root directory of your azure-libraries-for-java clone>`.

``` yaml $(java)
azure-arm: true
fluent: true
namespace: com.microsoft.azure.management.healthcareapis
license-header: MICROSOFT_MIT_NO_CODEGEN
payload-flattening-threshold: 1
output-folder: $(azure-libraries-for-java-folder)/azure-mgmt-healthcareapis
```

### Java multi-api

``` yaml $(java) && $(multiapi)
batch:
  - tag: package-2020-03-30
  - tag: package-2020-03
  - tag: package-2019-09  
  - tag: package-2018-08-preview
```

### Tag: package-2020-03-30 and java

These settings apply only when `--tag=package-2020-03-30 --java` is specified on the command line.
Please also specify `--azure-libraries-for-java=<path to the root directory of your azure-sdk-for-java clone>`.

``` yaml $(tag) == 'package-2020-03-30' && $(java) && $(multiapi)
java:
  namespace: com.microsoft.azure.management.healthcareapis.v2020_03_30
  output-folder: $(azure-libraries-for-java-folder)/sdk/healthcareapis/mgmt-v2020_03_30
regenerate-manager: true
generate-interface: true
```

### Tag: package-2020-03 and java

These settings apply only when `--tag=package-2020-03 --java` is specified on the command line.
Please also specify `--azure-libraries-for-java=<path to the root directory of your azure-sdk-for-java clone>`.

``` yaml $(tag) == 'package-2020-03' && $(java) && $(multiapi)
java:
  namespace: com.microsoft.azure.management.healthcareapis.v2020_03_15
  output-folder: $(azure-libraries-for-java-folder)/sdk/healthcareapis/mgmt-v2020_03_15
regenerate-manager: true
generate-interface: true
```

### Tag: package-2019-09 and java

These settings apply only when `--tag=package-2019-09 --java` is specified on the command line.
Please also specify `--azure-libraries-for-java=<path to the root directory of your azure-sdk-for-java clone>`.

``` yaml $(tag) == 'package-2019-09' && $(java) && $(multiapi)
java:
  namespace: com.microsoft.azure.management.healthcareapis.v2019_09_16
  output-folder: $(azure-libraries-for-java-folder)/sdk/healthcareapis/mgmt-v2019_09_16
regenerate-manager: true
generate-interface: true
```

### Tag: package-2018-08-preview and java

These settings apply only when `--tag=package-2018-08-preview --java` is specified on the command line.
Please also specify `--azure-libraries-for-java=<path to the root directory of your azure-sdk-for-java clone>`.

``` yaml $(tag) == 'package-2018-08-preview' && $(java) && $(multiapi)
java:
  namespace: com.microsoft.azure.management.healthcareapis.v2018_08_20_preview
  output-folder: $(azure-libraries-for-java-folder)/sdk/healthcareapis/mgmt-v2018_08_20_preview
regenerate-manager: true
generate-interface: true
```
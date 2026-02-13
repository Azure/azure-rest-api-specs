## Java

These settings apply only when `--java` is specified on the command line.
Please also specify `--azure-libraries-for-java-folder=<path to the root directory of your azure-libraries-for-java clone>`.

``` yaml $(java)
azure-arm: true
fluent: true
namespace: com.microsoft.azure.management.prometheusrulegroups
license-header: MICROSOFT_MIT_NO_CODEGEN
payload-flattening-threshold: 1
output-folder: $(azure-libraries-for-java-folder)/azure-mgmt-prometheusrulegroups
```

### Java multi-api

``` yaml $(java) && $(multiapi)
batch:
  - tag: package-2023-03
  - tag: package-preview-2021-07
```

### Tag: package-2023-03 and java

These settings apply only when `--tag=package-2023-03 --java` is specified on the command line.
Please also specify `--azure-libraries-for-java-folder=<path to the root directory of your azure-sdk-for-java clone>`.

``` yaml $(tag)=='package-2023-03' && $(java) && $(multiapi)
java:
  namespace: com.microsoft.azure.management.prometheusrulegroups.v2023_03_01
  output-folder: $(azure-libraries-for-java-folder)/sdk/prometheusrulegroups/mgmt-v2023_03_01
regenerate-manager: true
generate-interface: true
```

### Tag: package-preview-2021-07 and java

These settings apply only when `--tag=package-preview-2021-07 --java` is specified on the command line.
Please also specify `--azure-libraries-for-java-folder=<path to the root directory of your azure-sdk-for-java clone>`.

``` yaml $(tag)=='package-preview-2021-07' && $(java) && $(multiapi)
java:
  namespace: com.microsoft.azure.management.prometheusrulegroups.v2021_07_22_preview
  output-folder: $(azure-libraries-for-java-folder)/sdk/prometheusrulegroups/mgmt-v2021_07_22_preview
regenerate-manager: true
generate-interface: true
```

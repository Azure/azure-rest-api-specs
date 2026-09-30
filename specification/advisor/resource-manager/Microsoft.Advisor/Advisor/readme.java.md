## Java

These settings apply only when `--java` is specified on the command line.
Please also specify `--azure-libraries-for-java-folder=<path to the root directory of your azure-libraries-for-java clone>`.

``` yaml $(java)
azure-arm: true
fluent: true
namespace: com.microsoft.azure.management.advisor
license-header: MICROSOFT_MIT_NO_CODEGEN
payload-flattening-threshold: 1
output-folder: $(azure-libraries-for-java-folder)/azure-mgmt-advisor
```

### Java multi-api

``` yaml $(java) && $(multiapi)
batch:
  - tag: package-2017-04
  - tag: package-2017-03
  - tag: package-2016-07-preview
```

### Tag: package-2017-04 and java

These settings apply only when `--tag=package-2017-04 --java` is specified on the command line.
Please also specify `--azure-libraries-for-java=<path to the root directory of your azure-sdk-for-java clone>`.

``` yaml $(tag) == 'package-2017-04' && $(java) && $(multiapi)
java:
  namespace: com.microsoft.azure.management.advisor.v2017_04_19
  output-folder: $(azure-libraries-for-java-folder)/sdk/advisor/mgmt-v2017_04_19
regenerate-manager: true
generate-interface: true
```

### Tag: package-2017-03 and java

These settings apply only when `--tag=package-2017-03 --java` is specified on the command line.
Please also specify `--azure-libraries-for-java=<path to the root directory of your azure-sdk-for-java clone>`.

``` yaml $(tag) == 'package-2017-03' && $(java) && $(multiapi)
java:
  namespace: com.microsoft.azure.management.advisor.v2017_03_31
  output-folder: $(azure-libraries-for-java-folder)/sdk/advisor/mgmt-v2017_03_31
regenerate-manager: true
generate-interface: true
```

### Tag: package-2016-07-preview and java

These settings apply only when `--tag=package-2016-07-preview --java` is specified on the command line.
Please also specify `--azure-libraries-for-java=<path to the root directory of your azure-sdk-for-java clone>`.

``` yaml $(tag) == 'package-2016-07-preview' && $(java) && $(multiapi)
java:
  namespace: com.microsoft.azure.management.advisor.v2016_07_12_preview
  output-folder: $(azure-libraries-for-java-folder)/sdk/advisor/mgmt-v2016_07_12_preview
regenerate-manager: true
generate-interface: true
```
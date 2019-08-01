## Java

These settings apply only when `--java` is specified on the command line.
Please also specify `--azure-libraries-for-java-folder=<path to the root directory of your azure-libraries-for-java clone>`.

``` yaml $(java)
azure-arm: true
fluent: true
namespace: com.microsoft.azure.management.datafactory
license-header: MICROSOFT_MIT_NO_CODEGEN
payload-flattening-threshold: 1
output-folder: $(azure-libraries-for-java-folder)/azure-mgmt-datafactory
```

# Validation


### Java multi-api

``` yaml $(java) && $(multiapi)
batch:
  - tag: package-2017-09-preview
  - tag: package-2018-06
```

### Tag: package-2017-09-preview and java

These settings apply only when `--tag=package-2017-09-preview --java` is specified on the command line.
Please also specify `--azure-libraries-for-java=<path to the root directory of your azure-sdk-for-java clone>`.

``` yaml $(tag) == 'package-2017-09-preview' && $(java) && $(multiapi)
java:
  namespace: com.microsoft.azure.management.datafactory.v2017_09_01_preview
  output-folder: $(azure-libraries-for-java-folder)/datafactory/resource-manager/v2017_09_01_preview
regenerate-manager: true
generate-interface: true
```

### Tag: package-2018-06 and java

These settings apply only when `--tag=package-2018-06 --java` is specified on the command line.
Please also specify `--azure-libraries-for-java=<path to the root directory of your azure-sdk-for-java clone>`.

``` yaml $(tag) == 'package-2018-06' && $(java) && $(multiapi)
java:
  namespace: com.microsoft.azure.management.datafactory.v2018_06_01
  output-folder: $(azure-libraries-for-java-folder)/datafactory/resource-manager/v2018_06_01
regenerate-manager: true
generate-interface: true
```
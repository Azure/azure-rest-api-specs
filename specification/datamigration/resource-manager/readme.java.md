## Java

These settings apply only when `--java` is specified on the command line.
Please also specify `--azure-libraries-for-java-folder=<path to the root directory of your azure-libraries-for-java clone>`.

``` yaml $(java)
azure-arm: true
fluent: true
namespace: com.microsoft.azure.management.datamigration
license-header: MICROSOFT_MIT_NO_CODEGEN
payload-flattening-threshold: 1
output-folder: $(azure-libraries-for-java-folder)/azure-mgmt-datamigration
```

### Java multi-api

``` yaml $(java) && $(multiapi)
batch:
  - tag: package-2018-07-15-preview
  - tag: package-2017-11-15-preview
  - tag: package-2018-03-31-preview
```

### Tag: package-2018-07-15-preview and java

These settings apply only when `--tag=package-2018-07-15-preview --java` is specified on the command line.
Please also specify `--azure-libraries-for-java=<path to the root directory of your azure-sdk-for-java clone>`.

``` yaml $(tag) == 'package-2018-07-15-preview' && $(java) && $(multiapi)
java:
  namespace: com.microsoft.azure.management.datamigration.v2018_07_15_preview
  output-folder: $(azure-libraries-for-java-folder)/sdk/datamigration/mgmt-v2018_07_15_preview
regenerate-manager: true
generate-interface: true
```

### Tag: package-2017-11-15-preview and java

These settings apply only when `--tag=package-2017-11-15-preview --java` is specified on the command line.
Please also specify `--azure-libraries-for-java=<path to the root directory of your azure-sdk-for-java clone>`.

``` yaml $(tag) == 'package-2017-11-15-preview' && $(java) && $(multiapi)
java:
  namespace: com.microsoft.azure.management.datamigration.v2017_11_15_preview
  output-folder: $(azure-libraries-for-java-folder)/sdk/datamigration/mgmt-v2017_11_15_preview
regenerate-manager: true
generate-interface: true
```

### Tag: package-2018-03-31-preview and java

These settings apply only when `--tag=package-2018-03-31-preview --java` is specified on the command line.
Please also specify `--azure-libraries-for-java=<path to the root directory of your azure-sdk-for-java clone>`.

``` yaml $(tag) == 'package-2018-03-31-preview' && $(java) && $(multiapi)
java:
  namespace: com.microsoft.azure.management.datamigration.v2018_03_31_preview
  output-folder: $(azure-libraries-for-java-folder)/sdk/datamigration/mgmt-v2018_03_31_preview
regenerate-manager: true
generate-interface: true
```

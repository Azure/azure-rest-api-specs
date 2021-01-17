## Java

These settings apply only when `--java` is specified on the command line.
Please also specify `--azure-libraries-for-java-folder=<path to the root directory of your azure-libraries-for-java clone>`.

``` yaml $(java)
azure-arm: true
fluent: true
namespace: com.microsoft.azure.management.digitaltwins
license-header: MICROSOFT_MIT_NO_CODEGEN
payload-flattening-threshold: 1
output-folder: $(azure-libraries-for-java-folder)/azure-mgmt-digitaltwins
```

### Java multi-api

``` yaml $(java) && $(multiapi)
batch:
  - tag: package-2020-12
  - tag: package-2020-10
  - tag: package-2020-03-01-preview
```

### Tag: package-2020-12 and java

These settings apply only when `--tag=package-2020-12 --java` is specified on the command line.
Please also specify `--azure-libraries-for-java=<path to the root directory of your azure-sdk-for-java clone>`.

``` yaml $(tag) == 'package-2020-12' && $(java) && $(multiapi)
java:
  namespace: com.microsoft.azure.management.digitaltwins.v2020_12_01
  output-folder: $(azure-libraries-for-java-folder)/sdk/digitaltwins/mgmt-v2020_12_01
regenerate-manager: true
generate-interface: true
```

### Tag: package-2020-10 and java

These settings apply only when `--tag=package-2020-10 --java` is specified on the command line.
Please also specify `--azure-libraries-for-java=<path to the root directory of your azure-sdk-for-java clone>`.

``` yaml $(tag) == 'package-2020-10' && $(java) && $(multiapi)
java:
  namespace: com.microsoft.azure.management.digitaltwins.v2020_10_31
  output-folder: $(azure-libraries-for-java-folder)/sdk/digitaltwins/mgmt-v2020_10_31
regenerate-manager: true
generate-interface: true
```

### Tag: package-2020-03-01-preview and java

These settings apply only when `--tag=package-2020-03-01-preview --java` is specified on the command line.
Please also specify `--azure-libraries-for-java=<path to the root directory of your azure-sdk-for-java clone>`.

``` yaml $(tag) == 'package-2020-03-01-preview' && $(java) && $(multiapi)
java:
  namespace: com.microsoft.azure.management.digitaltwins.v2020_03_01_preview
  output-folder: $(azure-libraries-for-java-folder)/sdk/digitaltwins/mgmt-v2020_03_01_preview
regenerate-manager: true
generate-interface: true
```

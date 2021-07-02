## Java

These settings apply only when `--java` is specified on the command line.
Please also specify `--azure-libraries-for-java-folder=<path to the root directory of your azure-libraries-for-java clone>`.

``` yaml $(java)
azure-arm: true
fluent: true
namespace: com.microsoft.azure.management.dataprotection
license-header: MICROSOFT_MIT_NO_CODEGEN
payload-flattening-threshold: 1
output-folder: $(azure-libraries-for-java-folder)/azure-mgmt-dataprotection
```


### Java multi-api

``` yaml $(java) && $(multiapi)
batch:
  - tag: package-2021-06-preview
  - tag: package-2021-02-preview
  - tag: package-2021-01
```

### Tag: package-2021-01 and java

These settings apply only when `--tag=package-2021-01 --java` is specified on the command line.
Please also specify `--azure-libraries-for-java=<path to the root directory of your azure-sdk-for-java clone>`.

``` yaml $(tag) == 'package-2021-01' && $(java) && $(multiapi)
java:
  namespace: com.microsoft.azure.management.dataprotection.v2021_01_01
  output-folder: $(azure-libraries-for-java-folder)/dataprotection/resource-manager/v2021_01_01
regenerate-manager: true
generate-interface: true
```

### Tag: package-2021-02-preview and java

These settings apply only when `--tag=package-2021-02-preview --java` is specified on the command line.
Please also specify `--azure-libraries-for-java=<path to the root directory of your azure-sdk-for-java clone>`.

``` yaml $(tag) == 'package-2021-02-preview' && $(java) && $(multiapi)
java:
  namespace: com.microsoft.azure.management.dataprotection.v2021_02_01_preview
  output-folder: $(azure-libraries-for-java-folder)/dataprotection/resource-manager/v2021_02_01_preview
regenerate-manager: true
generate-interface: true
```

### Tag: package-2021-06-preview and java

These settings apply only when `--tag=package-2021-06-preview --java` is specified on the command line.
Please also specify `--azure-libraries-for-java=<path to the root directory of your azure-sdk-for-java clone>`.

``` yaml $(tag) == 'package-2021-06-preview' && $(java) && $(multiapi)
java:
  namespace: com.microsoft.azure.management.dataprotection.v2021_06_01_preview
  output-folder: $(azure-libraries-for-java-folder)/dataprotection/resource-manager/v2021_06_01_preview
regenerate-manager: true
generate-interface: true
```

## Java

These settings apply only when `--java` is specified on the command line.
Please also specify `--azure-libraries-for-java-folder=<path to the root directory of your azure-libraries-for-java clone>`.

``` yaml $(java)
azure-arm: true
fluent: true
namespace: com.microsoft.azure.management.windowsiot
license-header: MICROSOFT_MIT_NO_CODEGEN
payload-flattening-threshold: 1
output-folder: $(azure-libraries-for-java-folder)/azure-mgmt-windowsiot
```

### Java multi-api

``` yaml $(java) && $(multiapi)
batch:
  - tag: package-2019-06
  - tag: package-2018-02-preview
```

### Tag: package-2019-06 and java

These settings apply only when `--tag=package-2019-06 --java` is specified on the command line.
Please also specify `--azure-libraries-for-java=<path to the root directory of your azure-sdk-for-java clone>`.

``` yaml $(tag) == 'package-2019-06' && $(java) && $(multiapi)
java:
  namespace: com.microsoft.azure.management.windowsiot.v2019_06_01
  output-folder: $(azure-libraries-for-java-folder)/windowsiot/resource-manager/v2019_06_01
regenerate-manager: true
generate-interface: true
```

### Tag: package-2018-02-preview and java

These settings apply only when `--tag=package-2018-02-preview --java` is specified on the command line.
Please also specify `--azure-libraries-for-java=<path to the root directory of your azure-sdk-for-java clone>`.

``` yaml $(tag) == 'package-2018-02-preview' && $(java) && $(multiapi)
java:
  namespace: com.microsoft.azure.management.windowsiot.v2018_02_16_preview
  output-folder: $(azure-libraries-for-java-folder)/windowsiot/resource-manager/v2018_02_16_preview
regenerate-manager: true
generate-interface: true
```

`
## Java

These settings apply only when `--java` is specified on the command line.
Please also specify `--azure-libraries-for-java-folder=<path to the root directory of your azure-libraries-for-java clone>`.

``` yaml $(java)
azure-arm: true
fluent: true
namespace: com.microsoft.azure.management.servicefabric
license-header: MICROSOFT_MIT_NO_CODEGEN
payload-flattening-threshold: 1
output-folder: $(azure-libraries-for-java-folder)/azure-mgmt-servicefabric
```

### Java multi-api

``` yaml $(java) && $(multiapi)
batch:
  - tag: package-2018-02-only
  - tag: package-2017-07
  - tag: package-2016-09
```

### Tag: package-2018-02-only and java

These settings apply only when `--tag=package-2018-02-only --java` is specified on the command line.
Please also specify `--azure-libraries-for-java=<path to the root directory of your azure-sdk-for-java clone>`.

``` yaml $(tag) == 'package-2018-02-only' && $(java) && $(multiapi)
java:
  namespace: com.microsoft.azure.management.servicefabric.v2018_02_01
  output-folder: $(azure-libraries-for-java-folder)/sdk/servicefabric/mgmt-v2018_02_01
regenerate-manager: true
generate-interface: true
```

### Tag: package-2017-07 and java

These settings apply only when `--tag=package-2017-07 --java` is specified on the command line.
Please also specify `--azure-libraries-for-java=<path to the root directory of your azure-sdk-for-java clone>`.

``` yaml $(tag) == 'package-2017-07' && $(java) && $(multiapi)
java:
  namespace: com.microsoft.azure.management.servicefabric.v2017_07_01_preview
  output-folder: $(azure-libraries-for-java-folder)/sdk/servicefabric/mgmt-v2017_07_01_preview
regenerate-manager: true
generate-interface: true
```

### Tag: package-2016-09 and java

These settings apply only when `--tag=package-2016-09 --java` is specified on the command line.
Please also specify `--azure-libraries-for-java=<path to the root directory of your azure-sdk-for-java clone>`.

``` yaml $(tag) == 'package-2016-09' && $(java) && $(multiapi)
java:
  namespace: com.microsoft.azure.management.servicefabric.v2016_09_01
  output-folder: $(azure-libraries-for-java-folder)/sdk/servicefabric/mgmt-v2016_09_01
regenerate-manager: true
generate-interface: true
```

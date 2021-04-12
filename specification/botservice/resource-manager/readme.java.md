## Java

These settings apply only when `--java` is specified on the command line.
Please also specify `--azure-libraries-for-java-folder=<path to the root directory of your azure-libraries-for-java clone>`.

``` yaml $(java)
azure-arm: true
fluent: true
namespace: com.microsoft.azure.management.botservice
license-header: MICROSOFT_MIT_NO_CODEGEN
payload-flattening-threshold: 1
output-folder: $(azure-libraries-for-java-folder)/azure-mgmt-botservice
```

### Java multi-api

``` yaml $(java) && $(multiapi)
batch:
  - tag: package-2018-07-12
  - tag: package-2017-12-01
```

### Tag: package-2018-07-12 and java

These settings apply only when `--tag=package-2018-07-12 --java` is specified on the command line.
Please also specify `--azure-libraries-for-java=<path to the root directory of your azure-sdk-for-java clone>`.

``` yaml $(tag) == 'package-2018-07-12' && $(java) && $(multiapi)
java:
  namespace: com.microsoft.azure.management.botservice.v2018_07_12
  output-folder: $(azure-libraries-for-java-folder)/sdk/botservice/mgmt-v2018_07_12
regenerate-manager: true
generate-interface: true
```
### Tag: package-2017-12-01 and java

These settings apply only when `--tag=package-2017-12-01 --java` is specified on the command line.
Please also specify `--azure-libraries-for-java=<path to the root directory of your azure-sdk-for-java clone>`.

``` yaml $(tag) == 'package-2017-12-01' && $(java) && $(multiapi)
java:
  namespace: com.microsoft.azure.management.botservice.v2017_12_01
  output-folder: $(azure-libraries-for-java-folder)/sdk/botservice/mgmt-v2017_12_01
regenerate-manager: true
generate-interface: true
```
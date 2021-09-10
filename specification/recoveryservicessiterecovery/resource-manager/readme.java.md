## Java

These settings apply only when `--java` is specified on the command line.
Please also specify `--azure-libraries-for-java-folder=<path to the root directory of your azure-libraries-for-java clone>`.

``` yaml $(java)
azure-arm: true
fluent: true
namespace: com.microsoft.azure.management.recoveryservices.siterecovery
license-header: MICROSOFT_MIT_NO_CODEGEN
payload-flattening-threshold: 1
output-folder: $(azure-libraries-for-java-folder)/azure-mgmt-recoveryservices.siterecovery
```

### Java multi-api

``` yaml $(java) && $(multiapi)
batch:
  - tag: package-2018-01
  - tag: package-2016-08
```

### Tag: package-2018-01 and java

These settings apply only when `--tag=package-2018-01--java` is specified on the command line.
Please also specify `--azure-libraries-for-java=<path to the root directory of your azure-sdk-for-java clone>`.

``` yaml $(tag) == 'package-2018-01' && $(java) && $(multiapi)
java:
  namespace: com.microsoft.azure.management.recoveryservices.siterecovery.v2018_01_10
  output-folder: $(azure-libraries-for-java-folder)/sdk/recoveryservices.siterecovery/mgmt-v2018_01_10
regenerate-manager: true
generate-interface: true
```

### Tag: package-2016-08 and java

These settings apply only when `--tag=package-2016-08 --java` is specified on the command line.
Please also specify `--azure-libraries-for-java=<path to the root directory of your azure-sdk-for-java clone>`.

``` yaml $(tag) == 'package-2016-08' && $(java) && $(multiapi)
java:
  namespace: com.microsoft.azure.management.recoveryservices.siterecovery.v2016_08_10
  output-folder: $(azure-libraries-for-java-folder)/sdk/recoveryservices.siterecovery/mgmt-v2016_08_10
regenerate-manager: true
generate-interface: true
```

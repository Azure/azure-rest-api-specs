## Java

These settings apply only when `--java` is specified on the command line.
Please also specify `--azure-libraries-for-java-folder=<path to the root directory of your azure-libraries-for-java clone>`.

``` yaml $(java)
azure-arm: true
fluent: true
namespace: com.microsoft.azure.management.recoveryservicesbackup
license-header: MICROSOFT_MIT_NO_CODEGEN
payload-flattening-threshold: 1
output-folder: $(azure-libraries-for-java-folder)/azure-mgmt-recoveryservicesbackup
```


### Java multi-api

``` yaml $(java) && $(multiapi)
batch:
  - tag: package-2016-08
```

### Tag: package-2016-08 and java

These settings apply only when `--tag=package-2016-08 --java` is specified on the command line.
Please also specify `--azure-libraries-for-java=<path to the root directory of your azure-sdk-for-java clone>`.

``` yaml $(tag) == 'package-2016-08' && $(java) && $(multiapi)
java:
  namespace: com.microsoft.azure.management.recoveryservices.backup.v2016_08_10
  output-folder: $(azure-libraries-for-java-folder)/sdk/recoveryservices.backup/mgmt-v2016_08_10
regenerate-manager: true
generate-interface: true
```

### Tag: package-2016-06 and java

These settings apply only when `--tag=package-2016-06 --java` is specified on the command line.
Please also specify `--azure-libraries-for-java=<path to the root directory of your azure-sdk-for-java clone>`.

``` yaml $(tag) == 'package-2016-06' && $(java) && $(multiapi)
java:
  namespace: com.microsoft.azure.management.recoveryservices.backup.v2016_06_01
  output-folder: $(azure-libraries-for-java-folder)/sdk/recoveryservices.backup/mgmt-v2016_06_01
regenerate-manager: true
generate-interface: true
```

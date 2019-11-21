## Java

These settings apply only when `--java` is specified on the command line.
Please also specify `--azure-libraries-for-java-folder=<path to the root directory of your azure-libraries-for-java clone>`.

``` yaml $(java)
azure-arm: true
fluent: true
namespace: com.microsoft.azure.management.mariadb
license-header: MICROSOFT_MIT_NO_CODEGEN
payload-flattening-threshold: 1
output-folder: $(azure-libraries-for-java-folder)/azure-mgmt-mariadb
service-name: MariaDB
```

### Java multi-api

``` yaml $(java) && $(multiapi)
batch:
  - tag: package-2018-06-01
```

### Tag: package-2018-06-01 and java

These settings apply only when `--tag=package-2018-06-01 --java` is specified on the command line.
Please also specify `--azure-libraries-for-java-folder=<path to the root directory of your azure-sdk-for-java clone>`.

``` yaml $(tag) == 'package-2018-06-01' && $(java) && $(multiapi)
java:
  namespace: com.microsoft.azure.management.mariadb.v2018_06_01
  output-folder: $(azure-libraries-for-java-folder)/sdk/mariadb/mgmt-v2018_06_01
regenerate-manager: true
generate-interface: true
```

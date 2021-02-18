## Java

These settings apply only when `--java` is specified on the command line.
Please also specify `--azure-libraries-for-java-folder=<path to the root directory of your azure-libraries-for-java clone>`.

``` yaml $(java)
azure-arm: true
fluent: true
namespace: com.microsoft.azure.management.postgresql
license-header: MICROSOFT_MIT_NO_CODEGEN
payload-flattening-threshold: 1
output-folder: $(azure-libraries-for-java-folder)/azure-mgmt-postgresql
```

### Java multi-api

``` yaml $(java) && $(multiapi)
batch:
  - tag: package-2017-12-01-preview
  - tag: package-2017-12-01
```

### Tag: package-2017-12-01-preview and java

These settings apply only when `--tag=package-2017-12-01-preview --java` is specified on the command line.
Please also specify `--azure-libraries-for-java-folder=<path to the root directory of your azure-sdk-for-java clone>`.

``` yaml $(tag) == 'package-2017-12-01-preview' && $(java) && $(multiapi)
java:
  namespace: com.microsoft.azure.management.postgresql.v2017_12_01_preview
  output-folder: $(azure-libraries-for-java-folder)/sdk/postgresql/mgmt-v2017_12_01_preview
regenerate-manager: true
generate-interface: true
```

### Tag: package-2017-12-01 and java

These settings apply only when `--tag=package-2017-12-01 --java` is specified on the command line.
Please also specify `--azure-libraries-for-java-folder=<path to the root directory of your azure-sdk-for-java clone>`.

``` yaml $(tag) == 'package-2017-12-01' && $(java) && $(multiapi)
java:
  namespace: com.microsoft.azure.management.postgresql.v2017_12_01
  output-folder: $(azure-libraries-for-java-folder)/sdk/postgresql/mgmt-v2017_12_01
regenerate-manager: true
generate-interface: true
```

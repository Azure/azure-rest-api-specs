## Java

These settings apply only when `--java` is specified on the command line.
Please also specify `--azure-libraries-for-java-folder=<path to the root directory of your azure-libraries-for-java clone>`.

``` yaml $(java)
azure-arm: true
fluent: true
namespace: com.microsoft.azure.management.postgresqlhsc
license-header: MICROSOFT_MIT_NO_CODEGEN
payload-flattening-threshold: 1
output-folder: $(azure-libraries-for-java-folder)/azure-mgmt-postgresqlhsc
```

### Java multi-api

``` yaml $(java) && $(multiapi)
batch:
  - tag: package-2020-10-05-privatepreview
```

### Tag: package-2020-10-05-privatepreview and java

These settings apply only when `--tag=package-2020-10-05-privatepreview --java` is specified on the command line.
Please also specify `--azure-libraries-for-java-folder=<path to the root directory of your azure-sdk-for-java clone>`.

``` yaml $(tag) == 'package-2020-10-05-privatepreview' && $(java) && $(multiapi)
java:
  namespace: com.microsoft.azure.management.postgresqlhsc.v2020_10_05_privatepreview
  output-folder: $(azure-libraries-for-java-folder)/sdk/postgresqlhsc/mgmt-v2020_10_05_privatepreview
regenerate-manager: true
generate-interface: true
```
## Java

These settings apply only when `--java` is specified on the command line.
Please also specify `--azure-libraries-for-java-folder=<path to the root directory of your azure-libraries-for-java clone>`.

``` yaml $(java)
azure-arm: true
fluent: true
namespace: com.microsoft.azure.management.cosmosdbforpostgresql
license-header: MICROSOFT_MIT_NO_CODEGEN
payload-flattening-threshold: 1
output-folder: $(azure-libraries-for-java-folder)/azure-mgmt-cosmosdbforpostgresql
```

### Java multi-api

``` yaml $(java) && $(multiapi)
batch:
  - tag: package-2022-11-08
  - tag: package-2020-10-05-privatepreview
```

### Tag: package-2022-11-08 and java

These settings apply only when `--tag=package-2022-11-08 --java` is specified on the command line.
Please also specify `--azure-libraries-for-java-folder=<path to the root directory of your azure-sdk-for-java clone>`.

``` yaml $(tag) == 'package-2022-11'-08 && $(java) && $(multiapi)
java:
  namespace: com.microsoft.azure.management.cosmosdbforpostgresql.v2022-11-08
  output-folder: $(azure-libraries-for-java-folder)/sdk/cosmosdbforpostgresql/mgmt-v2022-11-08
regenerate-manager: true
generate-interface: true
```
### Tag: package-2020-10-05-privatepreview and java

These settings apply only when `--tag=package-2020-10-05-privatepreview --java` is specified on the command line.
Please also specify `--azure-libraries-for-java-folder=<path to the root directory of your azure-sdk-for-java clone>`.

``` yaml $(tag) == 'package-2020-10-05-privatepreview'-08 && $(java) && $(multiapi)
java:
  namespace: com.microsoft.azure.management.cosmosdbforpostgresql.v2020-10-05-privatepreview
  output-folder: $(azure-libraries-for-java-folder)/sdk/cosmosdbforpostgresql/mgmt-v2020-10-05-privatepreview
regenerate-manager: true
generate-interface: true
```

## Java

These settings apply only when `--java` is specified on the command line.
Please also specify `--azure-libraries-for-java-folder=<path to the root directory of your azure-libraries-for-java clone>`.

``` yaml $(java)
azure-arm: true
fluent: true
namespace: com.microsoft.azure.management.cosmosdb
license-header: MICROSOFT_MIT_NO_CODEGEN
payload-flattening-threshold: 1
output-folder: $(azure-libraries-for-java-folder)/azure-mgmt-cosmosdb
service-name: CosmosDB
```

### Java multi-api

``` yaml $(java) && $(multiapi)
batch:
  - tag: package-2019-08
  - tag: package-2019-08-preview
  - tag: package-2015-04
```

### Tag: package-2019-08 and java

These settings apply only when `--tag=package-2019-08 --java` is specified on the command line.
Please also specify `--azure-libraries-for-java=<path to the root directory of your azure-sdk-for-java clone>`.

``` yaml $(tag) == 'package-2019-08' && $(java) && $(multiapi)
java:
  namespace: com.microsoft.azure.management.cosmosdb.v2019_08_01
  output-folder: $(azure-libraries-for-java-folder)/sdk/cosmosdb/mgmt-v2019_08_01
regenerate-manager: true
generate-interface: true
```

### Tag: package-2019-08-preview and java

These settings apply only when `--tag=package-2019-08-preview --java` is specified on the command line.
Please also specify `--azure-libraries-for-java=<path to the root directory of your azure-sdk-for-java clone>`.

``` yaml $(tag) == 'package-2019-08-preview' && $(java) && $(multiapi)
java:
  namespace: com.microsoft.azure.management.cosmosdb.v2019_08_01_preview
  output-folder: $(azure-libraries-for-java-folder)/sdk/cosmosdb/mgmt-v2019_08_01_preview
regenerate-manager: true
generate-interface: true
```

### Tag: package-2015-04 and java

These settings apply only when `--tag=package-2015-04 --java` is specified on the command line.
Please also specify `--azure-libraries-for-java=<path to the root directory of your azure-sdk-for-java clone>`.

``` yaml $(tag) == 'package-2015-04' && $(java) && $(multiapi)
java:
  namespace: com.microsoft.azure.management.cosmosdb.v2015_04_08
  output-folder: $(azure-libraries-for-java-folder)/sdk/cosmosdb/mgmt-v2015_04_08
regenerate-manager: true
generate-interface: true
```

### Tag: package-2014-04 and java

These settings apply only when `--tag=package-2014-04 --java` is specified on the command line.
Please also specify `--azure-libraries-for-java=<path to the root directory of your azure-sdk-for-java clone>`.

``` yaml $(tag) == 'package-2014-04' && $(java) && $(multiapi)
java:
  namespace: com.microsoft.azure.management.cosmosdb.v2014_04_01
  output-folder: $(azure-libraries-for-java-folder)/sdk/cosmosdb/mgmt-v2014_04_01
regenerate-manager: true
generate-interface: true
```

### Tag: package-2015-11 and java

These settings apply only when `--tag=package-2015-11 --java` is specified on the command line.
Please also specify `--azure-libraries-for-java=<path to the root directory of your azure-sdk-for-java clone>`.

``` yaml $(tag) == 'package-2015-11' && $(java) && $(multiapi)
java:
  namespace: com.microsoft.azure.management.cosmosdb.v2015_11_06
  output-folder: $(azure-libraries-for-java-folder)/sdk/cosmosdb/mgmt-v2015_11_06
regenerate-manager: true
generate-interface: true
```

### Tag: package-2016-03-19 and java

These settings apply only when `--tag=package-2016-03-19 --java` is specified on the command line.
Please also specify `--azure-libraries-for-java=<path to the root directory of your azure-sdk-for-java clone>`.

``` yaml $(tag) == 'package-2016-03-19' && $(java) && $(multiapi)
java:
  namespace: com.microsoft.azure.management.cosmosdb.v2016_03_19
  output-folder: $(azure-libraries-for-java-folder)/sdk/cosmosdb/mgmt-v2016_03_19
regenerate-manager: true
generate-interface: true
```

### Tag: package-2016-03-31 and java

These settings apply only when `--tag=package-2016-03-31 --java` is specified on the command line.
Please also specify `--azure-libraries-for-java=<path to the root directory of your azure-sdk-for-java clone>`.

``` yaml $(tag) == 'package-2016-03-31' && $(java) && $(multiapi)
java:
  namespace: com.microsoft.azure.management.cosmosdb.v2016_03_31
  output-folder: $(azure-libraries-for-java-folder)/sdk/cosmosdb/mgmt-v2016_03_31
regenerate-manager: true
generate-interface: true
```

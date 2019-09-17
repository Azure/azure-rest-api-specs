## Java

These settings apply only when `--java` is specified on the command line.
Please also specify `--azure-libraries-for-java-folder=<path to the root directory of your azure-libraries-for-java clone>`.

``` yaml $(java)
azure-arm: true
fluent: true
namespace: com.microsoft.azure.management.batch
license-header: MICROSOFT_MIT_NO_CODEGEN
payload-flattening-threshold: 1
output-folder: $(azure-libraries-for-java-folder)/azure-mgmt-batch
```

### Java multi-api

``` yaml $(java) && $(multiapi)
batch:
  - tag: package-2019-08
  - tag: package-2019-04
  - tag: package-2018-12
  - tag: package-2015-12
  - tag: package-2017-09
  - tag: package-2017-01
  - tag: package-2017-05
```

### Tag: package-2019-08 and java

These settings apply only when `--tag=package-2019-08 --java` is specified on the command line.
Please also specify `--azure-libraries-for-java=<path to the root directory of your azure-sdk-for-java clone>`.

``` yaml $(tag) == 'package-2019-08' && $(java) && $(multiapi)
java:
  namespace: com.microsoft.azure.management.batch.v2019_08_01
  output-folder: $(azure-libraries-for-java-folder)/batch/resource-manager/v2019_08_01
regenerate-manager: true
generate-interface: true
```

### Tag: package-2019-04 and java

These settings apply only when `--tag=package-2019-04 --java` is specified on the command line.
Please also specify `--azure-libraries-for-java=<path to the root directory of your azure-sdk-for-java clone>`.

``` yaml $(tag) == 'package-2019-04' && $(java) && $(multiapi)
java:
  namespace: com.microsoft.azure.management.batch.v2019_04_01
  output-folder: $(azure-libraries-for-java-folder)/batch/resource-manager/v2019_04_01
regenerate-manager: true
generate-interface: true
```

### Tag: package-2018-12 and java

These settings apply only when `--tag=package-2018-12 --java` is specified on the command line.
Please also specify `--azure-libraries-for-java=<path to the root directory of your azure-sdk-for-java clone>`.

``` yaml $(tag) == 'package-2018-12' && $(java) && $(multiapi)
java:
  namespace: com.microsoft.azure.management.batch.v2018_12_01
  output-folder: $(azure-libraries-for-java-folder)/batch/resource-manager/v2018_12_01
regenerate-manager: true
generate-interface: true
```

### Tag: package-2015-12 and java

These settings apply only when `--tag=package-2015-12 --java` is specified on the command line.
Please also specify `--azure-libraries-for-java=<path to the root directory of your azure-sdk-for-java clone>`.

``` yaml $(tag) == 'package-2015-12' && $(java) && $(multiapi)
java:
  namespace: com.microsoft.azure.management.batch.v2015_12_01
  output-folder: $(azure-libraries-for-java-folder)/batch/resource-manager/v2015_12_01
regenerate-manager: true
generate-interface: true
```

### Tag: package-2017-09 and java

These settings apply only when `--tag=package-2017-09 --java` is specified on the command line.
Please also specify `--azure-libraries-for-java=<path to the root directory of your azure-sdk-for-java clone>`.

``` yaml $(tag) == 'package-2017-09' && $(java) && $(multiapi)
java:
  namespace: com.microsoft.azure.management.batch.v2017_09_01
  output-folder: $(azure-libraries-for-java-folder)/batch/resource-manager/v2017_09_01
regenerate-manager: true
generate-interface: true
```

### Tag: package-2017-01 and java

These settings apply only when `--tag=package-2017-01 --java` is specified on the command line.
Please also specify `--azure-libraries-for-java=<path to the root directory of your azure-sdk-for-java clone>`.

``` yaml $(tag) == 'package-2017-01' && $(java) && $(multiapi)
java:
  namespace: com.microsoft.azure.management.batch.v2017_01_01
  output-folder: $(azure-libraries-for-java-folder)/batch/resource-manager/v2017_01_01
regenerate-manager: true
generate-interface: true
```

### Tag: package-2017-05 and java

These settings apply only when `--tag=package-2017-05 --java` is specified on the command line.
Please also specify `--azure-libraries-for-java=<path to the root directory of your azure-sdk-for-java clone>`.

``` yaml $(tag) == 'package-2017-05' && $(java) && $(multiapi)
java:
  namespace: com.microsoft.azure.management.batch.v2017_05_01
  output-folder: $(azure-libraries-for-java-folder)/batch/resource-manager/v2017_05_01
regenerate-manager: true
generate-interface: true
```
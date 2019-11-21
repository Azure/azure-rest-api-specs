## Java

These settings apply only when `--java` is specified on the command line.
Please also specify `--azure-libraries-for-java-folder=<path to the root directory of your azure-libraries-for-java clone>`.

``` yaml $(java)
azure-arm: true
fluent: true
namespace: com.microsoft.azure.management.apimanagement
license-header: MICROSOFT_MIT_NO_CODEGEN
payload-flattening-threshold: 1
output-folder: $(azure-libraries-for-java-folder)/azure-mgmt-apimanagement
```

### Java multi-api

``` yaml $(java) && $(multiapi)
batch:
  - tag: package-2019-01
  - tag: package-2018-06-preview
  - tag: package-2018-01
  - tag: package-2017-03
  - tag: package-2016-10
  - tag: package-2016-07
```

### Tag: package-2019-01 and java

These settings apply only when `--tag=package-2019-01 --java` is specified on the command line.
Please also specify `--azure-libraries-for-java=<path to the root directory of your azure-sdk-for-java clone>`.

``` yaml $(tag) == 'package-2019-01' && $(java) && $(multiapi)
java:
  namespace: com.microsoft.azure.management.apimanagement.v2019_01_01
  output-folder: $(azure-libraries-for-java-folder)/sdk/apimanagement/mgmt-v2019_01_01
regenerate-manager: true
generate-interface: true
```

### Tag: package-2018-06-preview and java

These settings apply only when `--tag=package-2018-06-preview --java` is specified on the command line.
Please also specify `--azure-libraries-for-java=<path to the root directory of your azure-sdk-for-java clone>`.

``` yaml $(tag) == 'package-2018-06-preview' && $(java) && $(multiapi)
java:
  namespace: com.microsoft.azure.management.apimanagement.v2018_06_01_preview
  output-folder: $(azure-libraries-for-java-folder)/sdk/apimanagement/mgmt-v2018_06_01_preview
regenerate-manager: true
generate-interface: true
```

### Tag: package-2018-01 and java

These settings apply only when `--tag=package-2018-01 --java` is specified on the command line.
Please also specify `--azure-libraries-for-java=<path to the root directory of your azure-sdk-for-java clone>`.

``` yaml $(tag) == 'package-2018-01' && $(java) && $(multiapi)
java:
  namespace: com.microsoft.azure.management.apimanagement.v2018_01_01
  output-folder: $(azure-libraries-for-java-folder)/sdk/apimanagement/mgmt-v2018_01_01
regenerate-manager: true
generate-interface: true
```

### Tag: package-2017-03 and java

These settings apply only when `--tag=package-2017-03 --java` is specified on the command line.
Please also specify `--azure-libraries-for-java=<path to the root directory of your azure-sdk-for-java clone>`.

``` yaml $(tag) == 'package-2017-03' && $(java) && $(multiapi)
java:
  namespace: com.microsoft.azure.management.apimanagement.v2017_03_01
  output-folder: $(azure-libraries-for-java-folder)/sdk/apimanagement/mgmt-v2017_03_01
regenerate-manager: true
generate-interface: true
```

### Tag: package-2016-10 and java

These settings apply only when `--tag=package-2016-10 --java` is specified on the command line.
Please also specify `--azure-libraries-for-java=<path to the root directory of your azure-sdk-for-java clone>`.

``` yaml $(tag) == 'package-2016-10' && $(java) && $(multiapi)
java:
  namespace: com.microsoft.azure.management.apimanagement.v2016_10_10
  output-folder: $(azure-libraries-for-java-folder)/sdk/apimanagement/mgmt-v2016_10_10
regenerate-manager: true
generate-interface: true
```

### Tag: package-2016-07 and java

These settings apply only when `--tag=package-2016-07 --java` is specified on the command line.
Please also specify `--azure-libraries-for-java=<path to the root directory of your azure-sdk-for-java clone>`.

``` yaml $(tag) == 'package-2016-07' && $(java) && $(multiapi)
java:
  namespace: com.microsoft.azure.management.apimanagement.v2016_07_07
  output-folder: $(azure-libraries-for-java-folder)/sdk/apimanagement/mgmt-v2016_07_07
regenerate-manager: true
generate-interface: true
```

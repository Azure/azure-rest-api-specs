## Java

These settings apply only when `--java` is specified on the command line.
Please also specify `--azure-libraries-for-java-folder=<path to the root directory of your azure-libraries-for-java clone>`.

``` yaml $(java)
azure-arm: true
fluent: true
namespace: com.microsoft.azure.management.kusto
license-header: MICROSOFT_MIT_NO_CODEGEN
payload-flattening-threshold: 1
output-folder: $(azure-libraries-for-java-folder)/azure-mgmt-kusto
```

### Java multi-api

``` yaml $(java) && $(multiapi)
batch:
  - tag: package-2019-11-09
  - tag: package-2020-02-15
  - tag: package-2020-06-14  
```

### Tag: package-2018-09-07-preview and java

These settings apply only when `--tag=package-2018-09-07-preview --java` is specified on the command line.
Please also specify `--azure-libraries-for-java=<path to the root directory of your azure-sdk-for-java clone>`.

``` yaml $(tag) == 'package-2018-09-07-preview' && $(java) && $(multiapi)
java:
  namespace: com.microsoft.azure.management.kusto.v2018_09_07_preview
  output-folder: $(azure-libraries-for-java-folder)/sdk/kusto/mgmt-v2018_09_07_preview
regenerate-manager: true
generate-interface: true
```

### Tag: package-2019-01-21 and java

These settings apply only when `--tag=package-2019-01-21 --java` is specified on the command line.
Please also specify `--azure-libraries-for-java=<path to the root directory of your azure-sdk-for-java clone>`.

``` yaml $(tag) == 'package-2019-01-21' && $(java) && $(multiapi)
java:
  namespace: com.microsoft.azure.management.kusto.v2019_01_21
  output-folder: $(azure-libraries-for-java-folder)/sdk/kusto/mgmt-v2019_01_21
regenerate-manager: true
generate-interface: true
```

### Tag: package-2019-05-15 and java

These settings apply only when `--tag=package-2019-05-15 --java` is specified on the command line.
Please also specify `--azure-libraries-for-java=<path to the root directory of your azure-sdk-for-java clone>`.

``` yaml $(tag) == 'package-2019-05-15' && $(java) && $(multiapi)
java:
  namespace: com.microsoft.azure.management.kusto.v2019_05_15
  output-folder: $(azure-libraries-for-java-folder)/sdk/kusto/mgmt-v2019_05_15
regenerate-manager: true
generate-interface: true
```

### Tag: package-2019-09-07 and java

These settings apply only when `--tag=package-2019-09-07 --java` is specified on the command line.
Please also specify `--azure-libraries-for-java=<path to the root directory of your azure-sdk-for-java clone>`.

``` yaml $(tag) == 'package-2019-09-07' && $(java) && $(multiapi)
java:
  namespace: com.microsoft.azure.management.kusto.v2019_09_07
  output-folder: $(azure-libraries-for-java-folder)/sdk/kusto/mgmt-v2019_09_07
regenerate-manager: true
generate-interface: true
```

### Tag: package-2019-11-09 and java

These settings apply only when `--tag=package-2019-11-09 --java` is specified on the command line.
Please also specify `--azure-libraries-for-java=<path to the root directory of your azure-sdk-for-java clone>`.

``` yaml $(tag) == 'package-2019-11-09' && $(java) && $(multiapi)
java:
  namespace: com.microsoft.azure.management.kusto.v2019_11_09
  output-folder: $(azure-libraries-for-java-folder)/sdk/kusto/mgmt-v2019_11_09
regenerate-manager: true
generate-interface: true
```

### Tag: package-2020-02-15 and java

These settings apply only when `--tag=package-2020-02-15 --java` is specified on the command line.
Please also specify `--azure-libraries-for-java=<path to the root directory of your azure-sdk-for-java clone>`.

``` yaml $(tag) == 'package-2020-02-15' && $(java) && $(multiapi)
java:
  namespace: com.microsoft.azure.management.kusto.v2020_02_15
  output-folder: $(azure-libraries-for-java-folder)/sdk/kusto/mgmt-v2020_02_15
regenerate-manager: true
generate-interface: true
```

### Tag: package-2020-06-14 and java

These settings apply only when `--tag=package-2020-06-14 --java` is specified on the command line.
Please also specify `--azure-libraries-for-java=<path to the root directory of your azure-sdk-for-java clone>`.

``` yaml $(tag) == 'package-2020-06-14' && $(java) && $(multiapi)
java:
  namespace: com.microsoft.azure.management.kusto.v2020_06_14
  output-folder: $(azure-libraries-for-java-folder)/sdk/kusto/mgmt-v2020_06_14
regenerate-manager: true
generate-interface: true
```
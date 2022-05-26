
### Java

These settings apply only when `--java` is specified on the command line.
Please also specify `--azure-libraries-for-java-folder=<path to the root directory of your azure-libraries-for-java clone>`.

``` yaml $(java)
azure-arm: true
fluent: true
namespace: com.microsoft.azure.management.sql
license-header: MICROSOFT_MIT_NO_CODEGEN
payload-flattening-threshold: 1
output-folder: $(azure-libraries-for-java-folder)/azure-mgmt-sql
```


### Java multi-api

``` yaml $(java) && $(multiapi)
batch:
  - tag: package-pure-2014-04
  - tag: package-pure-2015-05-preview
  - tag: package-pure-2017-03-preview
  - tag: package-pure-2017-10-preview
  - tag: package-pure-2018-06-preview
```

### Tag: package-pure-2014-04 and java

These settings apply only when `--tag=package-pure-2014-04 --java` is specified on the command line.
Please also specify `--azure-libraries-for-java=<path to the root directory of your azure-sdk-for-java clone>`.

``` yaml $(tag) == 'package-pure-2014-04' && $(java) && $(multiapi)
java:
  namespace: com.microsoft.azure.management.sql.v2014_04_01
  output-folder: $(azure-libraries-for-java-folder)/sdk/sql/mgmt-v2014_04_01
regenerate-manager: true
generate-interface: true
```

### Tag: package-pure-2015-05-preview and java

These settings apply only when `--tag=package-pure-2015-05-preview --java` is specified on the command line.
Please also specify `--azure-libraries-for-java=<path to the root directory of your azure-sdk-for-java clone>`.

``` yaml $(tag) == 'package-pure-2015-05-preview' && $(java) && $(multiapi)
java:
  namespace: com.microsoft.azure.management.sql.v2015_05_01_preview
  output-folder: $(azure-libraries-for-java-folder)/sdk/sql/mgmt-v2015_05_01_preview
regenerate-manager: true
generate-interface: true
```

### Tag: package-pure-2017-03-preview and java

These settings apply only when `--tag=package-pure-2017-03-preview --java` is specified on the command line.
Please also specify `--azure-libraries-for-java=<path to the root directory of your azure-sdk-for-java clone>`.

``` yaml $(tag) == 'package-pure-2017-03-preview' && $(java) && $(multiapi)
java:
  namespace: com.microsoft.azure.management.sql.v2017_03_01_preview
  output-folder: $(azure-libraries-for-java-folder)/sdk/sql/mgmt-v2017_03_01_preview
regenerate-manager: true
generate-interface: true
directive: 
  - rename-model: 
      from: DataWarehouseUserActivities 
      to: DataWarehouseUserActivity
  - rename-operation: 
      from: SensitivityLabels_ListRecommendedByDatabase 
      to: RecommendedSensitivityLabels_ListByDatabase
```

### Tag: package-pure-2017-10-preview and java

These settings apply only when `--tag=package-pure-2017-10-preview --java` is specified on the command line.
Please also specify `--azure-libraries-for-java=<path to the root directory of your azure-sdk-for-java clone>`.

``` yaml $(tag) == 'package-pure-2017-10-preview' && $(java) && $(multiapi)
java:
  namespace: com.microsoft.azure.management.sql.v2017_10_01_preview
  output-folder: $(azure-libraries-for-java-folder)/sdk/sql/mgmt-v2017_10_01_preview
regenerate-manager: true
generate-interface: true
```

### Tag: package-pure-2018-06-preview and java

These settings apply only when `--tag=package-pure-2018-06-preview --java` is specified on the command line.
Please also specify `--azure-libraries-for-java=<path to the root directory of your azure-sdk-for-java clone>`.

``` yaml $(tag) == 'package-pure-2018-06-preview' && $(java) && $(multiapi)
java:
  namespace: com.microsoft.azure.management.sql.v2018_06_01_preview
  output-folder: $(azure-libraries-for-java-folder)/sdk/sql/mgmt-v2018_06_01_preview
regenerate-manager: true
generate-interface: true
```

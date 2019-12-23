## Java

These settings apply only when `--java` is specified on the command line.
Please also specify `--azure-libraries-for-java-folder=<path to the root directory of your azure-libraries-for-java clone>`.

``` yaml $(java)
azure-arm: true
fluent: true
namespace: com.microsoft.azure.management.loganalytics
license-header: MICROSOFT_MIT_NO_CODEGEN
payload-flattening-threshold: 1
output-folder: $(azure-libraries-for-java-folder)/azure-mgmt-loganalytics
service-name: LogAnalytics
```


### Java multi-api

``` yaml $(java) && $(multiapi)
batch:
  - tag: package-2015-03
  - tag: package-2015-11-preview
```

### Tag: package-2015-03 and java

These settings apply only when `--tag=package-2015-03 --java` is specified on the command line.
Please also specify `--azure-libraries-for-java=<path to the root directory of your azure-sdk-for-java clone>`.

``` yaml $(tag) == 'package-2015-03' && $(java) && $(multiapi)
java:
  namespace: com.microsoft.azure.management.loganalytics.v2015_03_20
  output-folder: $(azure-libraries-for-java-folder)/sdk/loganalytics/mgmt-v2015_03_20
regenerate-manager: true
generate-interface: true
```

### Tag: package-2015-11-preview and java

These settings apply only when `--tag=package-2015-11-preview --java` is specified on the command line.
Please also specify `--azure-libraries-for-java=<path to the root directory of your azure-sdk-for-java clone>`.

``` yaml $(tag) == 'package-2015-11-preview' && $(java) && $(multiapi)
java:
  namespace: com.microsoft.azure.management.loganalytics.v2015_11_01_preview
  output-folder: $(azure-libraries-for-java-folder)/sdk/loganalytics/mgmt-v2015_11_01_preview
regenerate-manager: true
generate-interface: true
```
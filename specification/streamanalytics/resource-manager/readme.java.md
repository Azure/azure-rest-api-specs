## Java

These settings apply only when `--java` is specified on the command line.
Please also specify `--azure-libraries-for-java-folder=<path to the root directory of your azure-libraries-for-java clone>`.

``` yaml $(java)
azure-arm: true
fluent: true
namespace: com.microsoft.azure.management.streamanalytics
license-header: MICROSOFT_MIT_NO_CODEGEN
payload-flattening-threshold: 1
output-folder: $(azure-libraries-for-java-folder)/azure-mgmt-streamanalytics
service-name: StreamAnalytics
```

### Java multi-api

``` yaml $(java) && $(multiapi)
batch:
  - tag: package-2020-03-preview
```

### Tag: package-pure-2016-03 and java

These settings apply only when `--tag=package-pure-2016-03 --java` is specified on the command line.
Please also specify `--azure-libraries-for-java-folder=<path to the root directory of your azure-sdk-for-java clone>`.

``` yaml $(tag) == 'package-pure-2016-03' && $(java) && $(multiapi)
java:
  namespace: com.microsoft.azure.management.streamanalytics.v2016_03_01
  output-folder: $(azure-libraries-for-java-folder)/sdk/streamanalytics/mgmt-v2016_03_01
regenerate-manager: true
generate-interface: true
```

### Tag: package-pure-2017-04-preview and java

These settings apply only when `--tag=package-pure-2017-04-preview --java` is specified on the command line.
Please also specify `--azure-libraries-for-java-folder=<path to the root directory of your azure-sdk-for-java clone>`.

``` yaml $(tag) == 'package-pure-2017-04-preview' && $(java) && $(multiapi)
java:
  namespace: com.microsoft.azure.management.streamanalytics.v2017_04_01_preview
  output-folder: $(azure-libraries-for-java-folder)/sdk/streamanalytics/mgmt-v2017_04_01_preview
regenerate-manager: true
generate-interface: true
```

### Tag: package-2020-03-preview and java

These settings apply only when `--tag=package-2020-03-preview --java` is specified on the command line.
Please also specify `--azure-libraries-for-java-folder=<path to the root directory of your azure-sdk-for-java clone>`.

``` yaml $(tag) == 'package-2020-03-preview' && $(java) && $(multiapi)
java:
  namespace: com.microsoft.azure.management.streamanalytics.v2020_03_01_preview
  output-folder: $(azure-libraries-for-java-folder)/sdk/streamanalytics/mgmt-v2020_03_01_preview
regenerate-manager: true
generate-interface: true
```

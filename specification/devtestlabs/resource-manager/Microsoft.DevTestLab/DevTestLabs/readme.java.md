## Java

These settings apply only when `--java` is specified on the command line.
Please also specify `--azure-libraries-for-java-folder=<path to the root directory of your azure-libraries-for-java clone>`.

``` yaml $(java)
azure-arm: true
fluent: true
namespace: com.microsoft.azure.management.devtestlabs
license-header: MICROSOFT_MIT_NO_CODEGEN
payload-flattening-threshold: 1
output-folder: $(azure-libraries-for-java-folder)/azure-mgmt-devtestlabs
service-name: DevTestLabs
```

### Java multi-api

``` yaml $(java) && $(multiapi)
batch:
  - tag: package-2018-09
  - tag: package-2016-05
  - tag: package-2015-05-preview
```

### Tag: package-2018-09 and java

These settings apply only when `--tag=package-2018-09 --java` is specified on the command line.
Please also specify `--azure-libraries-for-java=<path to the root directory of your azure-sdk-for-java clone>`.

``` yaml $(tag) == 'package-2018-09' && $(java) && $(multiapi)
java:
  namespace: com.microsoft.azure.management.devtestlabs.v2018_09_15
  output-folder: $(azure-libraries-for-java-folder)/sdk/devtestlabs/mgmt-v2018_09_15
regenerate-manager: true
generate-interface: true
```

### Tag: package-2016-05 and java

These settings apply only when `--tag=package-2016-05 --java` is specified on the command line.
Please also specify `--azure-libraries-for-java=<path to the root directory of your azure-sdk-for-java clone>`.

``` yaml $(tag) == 'package-2016-05' && $(java) && $(multiapi)
java:
  namespace: com.microsoft.azure.management.devtestlabs.v2016_05_15
  output-folder: $(azure-libraries-for-java-folder)/sdk/devtestlabs/mgmt-v2016_05_15
regenerate-manager: true
generate-interface: true
```

### Tag: package-2015-05-preview and java

These settings apply only when `--tag=package-2015-05-preview --java` is specified on the command line.
Please also specify `--azure-libraries-for-java=<path to the root directory of your azure-sdk-for-java clone>`.

``` yaml $(tag) == 'package-2015-05-preview' && $(java) && $(multiapi)
java:
  namespace: com.microsoft.azure.management.devtestlabs.v2015_05_21_preview
  output-folder: $(azure-libraries-for-java-folder)/sdk/devtestlabs/mgmt-v2015_05_21_preview
regenerate-manager: true
generate-interface: true
```

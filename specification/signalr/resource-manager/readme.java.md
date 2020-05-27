## Java

These settings apply only when `--java` is specified on the command line.
Please also specify `--azure-libraries-for-java-folder=<path to the root directory of your azure-libraries-for-java clone>`.

``` yaml $(java)
azure-arm: true
fluent: true
namespace: com.microsoft.azure.management.signalr
license-header: MICROSOFT_MIT_NO_CODEGEN
payload-flattening-threshold: 1
output-folder: $(azure-libraries-for-java-folder)/azure-mgmt-signalr
```

### Java multi-api

``` yaml $(java) && $(multiapi)
batch:
  - tag: package-2018-03-01-preview
  - tag: package-2018-10-01
  - tag: package-2020-05-01
```

### Tag: package-2020-05-01 and java

These settings apply only when `--tag=package-2020-05-01 --java` is specified on the command line.
Please also specify `--azure-libraries-for-java-folder=<path to the root directory of your azure-sdk-for-java clone>`.

``` yaml $(tag) == 'package-2020-05-01' && $(java) && $(multiapi)
java:
  namespace: com.microsoft.azure.management.signalr.v2020_05_01
  output-folder: $(azure-libraries-for-java-folder)/sdk/signalr/mgmt-v2020_05_01
regenerate-manager: true
generate-interface: true
```

### Tag: package-2018-10-01 and java

These settings apply only when `--tag=package-2018-10-01 --java` is specified on the command line.
Please also specify `--azure-libraries-for-java-folder=<path to the root directory of your azure-sdk-for-java clone>`.

``` yaml $(tag) == 'package-2018-10-01' && $(java) && $(multiapi)
java:
  namespace: com.microsoft.azure.management.signalr.v2018_10_01
  output-folder: $(azure-libraries-for-java-folder)/sdk/signalr/mgmt-v2018_10_01
regenerate-manager: true
generate-interface: true
```

### Tag: package-2018-03-01-preview and java

These settings apply only when `--tag=package-2018-03-01-preview --java` is specified on the command line.
Please also specify `--azure-libraries-for-java-folder=<path to the root directory of your azure-sdk-for-java clone>`.

``` yaml $(tag) == 'package-2018-03-01-preview' && $(java) && $(multiapi)
java:
  namespace: com.microsoft.azure.management.signalr.v2018_03_01_preview
  output-folder: $(azure-libraries-for-java-folder)/sdk/signalr/mgmt-v2018_03_01_preview
regenerate-manager: true
generate-interface: true
```

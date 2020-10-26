## Java

These settings apply only when `--java` is specified on the command line.
Please also specify `--azure-libraries-for-java-folder=<path to the root directory of your azure-libraries-for-java clone>`.

``` yaml $(java)
azure-arm: true
fluent: true
namespace: com.microsoft.azure.management.communication
license-header: MICROSOFT_MIT_NO_CODEGEN
payload-flattening-threshold: 1
output-folder: $(azure-libraries-for-java-folder)/azure-mgmt-communication
```

### Java multi-api

``` yaml $(java) && $(multiapi)
batch:
  - tag: package-2020-08-20-preview
```

### Tag: package-2020-08-20-preview and java

These settings apply only when `--tag=package-2020-08-20-preview --java` is specified on the command line.
Please also specify `--azure-libraries-for-java=<path to the root directory of your azure-sdk-for-java clone>`.

``` yaml $(tag) == 'package-2020-03-01-preview' && $(java) && $(multiapi)
java:
  namespace: com.microsoft.azure.management.communication.v2020_08_20_preview
  output-folder: $(azure-libraries-for-java-folder)/sdk/communication/mgmt-v2020_08_20_preview
regenerate-manager: true
generate-interface: true
```
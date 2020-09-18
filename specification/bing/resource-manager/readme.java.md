## Java

These settings apply only when `--java` is specified on the command line.
Please also specify `--azure-libraries-for-java-folder=<path to the root directory of your azure-libraries-for-java clone>`.

``` yaml $(java)
azure-arm: true
fluent: true
namespace: com.microsoft.azure.management.bing
license-header: MICROSOFT_MIT_NO_CODEGEN
payload-flattening-threshold: 1
output-folder: $(azure-libraries-for-java-folder)/azure-mgmt-bing
```

### Java multi-api

``` yaml $(java) && $(multiapi)
batch:
  - tag: package-2020-06-10
  - tag: package-2020-06-10-preview
```

### Tag: package-2020-06-10 and java

These settings apply only when `--tag=package-2020-06-10 --java` is specified on the command line.
Please also specify `--azure-libraries-for-java-folder=<path to the root directory of your azure-sdk-for-java clone>`.

``` yaml $(tag) == 'package-2020-06-10' && $(java) && $(multiapi)
java:
  namespace: com.microsoft.azure.management.bing.v2020_06_10
  output-folder: $(azure-libraries-for-java-folder)/sdk/bing/mgmt-v2020_06_10
regenerate-manager: true
generate-interface: true
```

### Tag: package-2020-06-10-preview and java

These settings apply only when `--tag=package-2020-06-10-preview --java` is specified on the command line.
Please also specify `--azure-libraries-for-java-folder=<path to the root directory of your azure-sdk-for-java clone>`.

``` yaml $(tag) == 'package-2020-06-10-preview' && $(java) && $(multiapi)
java:
  namespace: com.microsoft.azure.management.bing.v2020_06_10_preview
  output-folder: $(azure-libraries-for-java-folder)/sdk/bing/mgmt-v2020_06_10_preview
regenerate-manager: true
generate-interface: true
```
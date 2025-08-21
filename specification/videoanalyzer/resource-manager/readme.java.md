## Java

These settings apply only when `--java` is specified on the command line.
Please also specify `--azure-libraries-for-java-folder=<path to the root directory of your azure-libraries-for-java clone>`.

``` yaml $(java)
azure-arm: true
fluent: true
namespace: com.microsoft.azure.management.videoanalyzer
license-header: MICROSOFT_MIT_NO_CODEGEN
payload-flattening-threshold: 2
output-folder: $(azure-libraries-for-java-folder)/azure-mgmt-videoanalyzer

service-name: Video Analyzer
```

### Java multi-api

``` yaml $(java) && $(multiapi)
batch:
  - tag: package-2021-05-01-preview
```

### Tag: package-2021-05-01-preview and java

These settings apply only when `--tag=package-2021-05-01-preview --java` is specified on the command line.
Please also specify `--azure-libraries-for-java-folder=<path to the root directory of your azure-sdk-for-java clone>`.

``` yaml $(tag) == 'package-2021-05-01-preview' && $(java) && $(multiapi)
java:
  namespace: com.microsoft.azure.management.videoanalyzer.v2021_05_01_preview
  output-folder: $(azure-libraries-for-java-folder)/sdk/videoanalyzer/mgmt-v2021_05_01_preview
regenerate-manager: true
generate-interface: true
```
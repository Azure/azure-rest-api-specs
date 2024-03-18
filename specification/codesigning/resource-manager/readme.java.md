These settings apply only when `--java` is specified on the command line.
Please also specify `--azure-libraries-for-java-folder=<path to the root directory of your azure-libraries-for-java clone>`.

``` yaml $(java)
azure-arm: true
fluent: true
namespace: com.microsoft.azure.management.codesigning
license-header: MICROSOFT_MIT_NO_CODEGEN
payload-flattening-threshold: 1
output-folder: $(azure-libraries-for-java-folder)/azure-mgmt-codesigning
```

### Java multi-api

``` yaml $(java) && $(multiapi)
batch:
  - tag: package-2024-02-05-preview
```

### Tag: package-2024-02-05-preview and java

These settings apply only when `--tag=package-2024-02-05-preview` is specified on the command line.
Please also specify `--azure-libraries-for-java-folder=<path to the root directory of your azure-sdk-for-java clone>`.

``` yaml $(tag) == 'package-2024-02-05-preview' && $(java) && $(multiapi)
java:
  namespace: com.microsoft.azure.management.codesigning.v2024_02_05_preview
  output-folder: $(azure-libraries-for-java-folder)/codesigning/resource-manager/v2024_02_05_preview
regenerate-manager: true
generate-interface: true
```

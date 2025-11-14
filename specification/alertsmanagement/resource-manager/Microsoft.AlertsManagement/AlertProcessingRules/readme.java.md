## Java

These settings apply only when `--java` is specified on the command line.
Please also specify `--azure-libraries-for-java-folder=<path to the root directory of your azure-libraries-for-java clone>`.

``` yaml $(java)
azure-arm: true
fluent: true
namespace: com.microsoft.azure.management.alertprocessingrules
license-header: MICROSOFT_MIT_NO_CODEGEN
payload-flattening-threshold: 1
output-folder: $(azure-libraries-for-java-folder)/azure-mgmt-alertprocessingrules
```

### Java multi-api

``` yaml $(java) && $(multiapi)
batch:
  - tag: package-2021-08
  - tag: package-preview-2021-08
  - tag: package-2019-06-preview
```

### Tag: package-2021-08 and java

These settings apply only when `--tag=package-2021-08 --java` is specified on the command line.
Please also specify `--azure-libraries-for-java-folder=<path to the root directory of your azure-sdk-for-java clone>`.

``` yaml $(tag)=='package-2021-08' && $(java) && $(multiapi)
java:
  namespace: com.microsoft.azure.management.alertprocessingrules.v2021_08_08
  output-folder: $(azure-libraries-for-java-folder)/sdk/alertprocessingrules/mgmt-v2021_08_08
regenerate-manager: true
generate-interface: true
```

### Tag: package-preview-2021-08 and java

These settings apply only when `--tag=package-preview-2021-08 --java` is specified on the command line.
Please also specify `--azure-libraries-for-java-folder=<path to the root directory of your azure-sdk-for-java clone>`.

``` yaml $(tag)=='package-preview-2021-08' && $(java) && $(multiapi)
java:
  namespace: com.microsoft.azure.management.alertprocessingrules.v2021_08_08_preview
  output-folder: $(azure-libraries-for-java-folder)/sdk/alertprocessingrules/mgmt-v2021_08_08_preview
regenerate-manager: true
generate-interface: true
```

### Tag: package-2019-06-preview and java

These settings apply only when `--tag=package-2019-06-preview --java` is specified on the command line.
Please also specify `--azure-libraries-for-java-folder=<path to the root directory of your azure-sdk-for-java clone>`.

``` yaml $(tag)=='package-2019-06-preview' && $(java) && $(multiapi)
java:
  namespace: com.microsoft.azure.management.alertprocessingrules.v2019_05_05_preview
  output-folder: $(azure-libraries-for-java-folder)/sdk/alertprocessingrules/mgmt-v2019_05_05_preview
regenerate-manager: true
generate-interface: true
```

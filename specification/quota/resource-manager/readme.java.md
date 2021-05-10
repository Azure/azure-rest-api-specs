## Java

These settings apply only when `--java` is specified on the command line.
Please also specify `--azure-libraries-for-java-folder=<path to the root directory of your azure-libraries-for-java clone>`.

``` yaml $(java)
azure-arm: true
fluent: true
namespace: com.microsoft.azure.management.quota
license-header: MICROSOFT_MIT_NO_CODEGEN
payload-flattening-threshold: 1
output-folder: $(azure-libraries-for-java-folder)/azure-mgmt-quota
```

### Java multi-api

```yaml $(java) && $(multiapi)
batch:
  - tag: package-2021-03-15-preview
```

### Tag: package-2021-03-15 and java

These settings apply only when `--tag=package-2021-03-15 --java` is specified on the command line.
Please also specify `--azure-libraries-for-java-folder=<path to the root directory of your azure-sdk-for-java clone>`.

``` yaml $(tag) == 'package-2021-03-15' && $(java) && $(multiapi)
java:
  namespace: com.microsoft.azure.management.quota.v2021_03_15
  output-folder: $(azure-libraries-for-java-folder)/sdk/quota/mgmt-v2021_03_15
regenerate-manager: true
generate-interface: true
```


### Tag: package-2021-03-15-preview and java

These settings apply only when `--tag=package-2021-03-15-preview --java` is specified on the command line.
Please also specify `--azure-libraries-for-java-folder=<path to the root directory of your azure-sdk-for-java clone>`.

``` yaml $(tag) == 'package-2021-03-15-preview' && $(java) && $(multiapi)
java:
  namespace: com.microsoft.azure.management.quota.v2021_03_15_preview
  output-folder: $(azure-libraries-for-java-folder)/sdk/quota/mgmt-v2021_03_15_preview
regenerate-manager: true
generate-interface: true
```

## Java

These settings apply only when `--java` is specified on the command line.
Please also specify `--azure-libraries-for-java-folder=<path to the root directory of your azure-libraries-for-java clone>`.

``` yaml $(java)
azure-arm: true
fluent: true
namespace: com.microsoft.azure.management.healthbot
license-header: MICROSOFT_MIT_NO_CODEGEN
payload-flattening-threshold: 1
output-folder: $(azure-libraries-for-java-folder)/azure-mgmt-healthbot
```

### Java multi-api

```yaml $(java) && $(multiapi)
batch:
  - tag: package-2021-06-10 
  - tag: package-2020-12-08
```

### Tag: package-2021-06-10 and java

These settings apply only when `--tag=package-2021-06-10 --java` is specified on the command line.
Please also specify `--azure-libraries-for-java-folder=<path to the root directory of your azure-sdk-for-java clone>`.

``` yaml $(tag) == 'package-2021-06-10' && $(java) && $(multiapi)
java:
  namespace: com.microsoft.azure.management.healthbot.v2021-06-10
  output-folder: $(azure-libraries-for-java-folder)/sdk/healthbot/mgmt-v2021-06-10
regenerate-manager: true
generate-interface: true
```

### Tag: package-2020-12-08 and java

These settings apply only when `--tag=package-2020-12-08 --java` is specified on the command line.
Please also specify `--azure-libraries-for-java-folder=<path to the root directory of your azure-sdk-for-java clone>`.

``` yaml $(tag) == 'package-2020-12-08' && $(java) && $(multiapi)
java:
  namespace: com.microsoft.azure.management.healthbot.v2020_12_08
  output-folder: $(azure-libraries-for-java-folder)/sdk/healthbot/mgmt-v2020_12_08
regenerate-manager: true
generate-interface: true
```
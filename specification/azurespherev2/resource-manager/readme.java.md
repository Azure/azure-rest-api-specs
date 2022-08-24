## Java

These settings apply only when `--java` is specified on the command line.
Please also specify `--azure-libraries-for-java-folder=<path to the root directory of your azure-libraries-for-java clone>`.

``` yaml $(java)
azure-arm: true
fluent: true
namespace: com.microsoft.azure.management.azurespherev2
license-header: MICROSOFT_MIT_NO_CODEGEN
payload-flattening-threshold: 1
output-folder: $(azure-libraries-for-java-folder)/azure-mgmt-azurespherev2
```

### Java multi-api

``` yaml $(java) && $(multiapi)
batch:
  - tag: package-2022-09-01-privatepreview
```

### Tag: package-2022-09-01-privatepreview and java

These settings apply only when `--tag=package-2022-09-01-privatepreview --java` is specified on the command line.
Please also specify `--azure-libraries-for-java=<path to the root directory of your azure-sdk-for-java clone>`.

``` yaml $(tag) == 'package-2022-09-01-privatepreview' && $(java) && $(multiapi)
java:
  namespace: com.microsoft.azure.management.azurespherev2.v2022_09_01_privatepreview
  output-folder: $(azure-libraries-for-java-folder)/sdk/azurespherev2/mgmt-v2022_09_01_privatepreview
regenerate-manager: true
generate-interface: true
```
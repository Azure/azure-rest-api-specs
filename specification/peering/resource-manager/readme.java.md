## Java

These settings apply only when `--java` is specified on the command line.
Please also specify `--azure-libraries-for-java-folder=<path to the root directory of your azure-libraries-for-java clone>`.

``` yaml $(java)
azure-arm: true
fluent: true
namespace: com.microsoft.azure.management.peering
license-header: MICROSOFT_MIT_NO_CODEGEN
payload-flattening-threshold: 1
output-folder: $(azure-libraries-for-java-folder)/azure-mgmt-peering
```

### Java multi-api
``` yaml $(java) && $(multiapi)
batch:
  - tag: package-2020-10-01
```
or
``` yaml $(java) && $(multiapi)
batch:
  - tag: package-2020-04-01
```
or
``` yaml $(java) && $(multiapi)
batch:
  - tag: package-2020-01-01-preview
```
or
``` yaml $(java) && $(multiapi)
batch:
  - tag: package-2019-09-01-preview
```
or
``` yaml $(java) && $(multiapi)
batch:
  - tag: package-2019-08-01-preview
```

### Tag: package-2020-10-01 and java

These settings apply only when `--tag=package-2020-10-01 --java` is specified on the command line.
Please also specify `--azure-libraries-for-java=<path to the root directory of your azure-sdk-for-java clone>`.

``` yaml $(tag) == 'package-2020-10-01' && $(java) && $(multiapi)
java:
  namespace: com.microsoft.azure.management.peering.v2020_10_01
  output-folder: $(azure-libraries-for-java-folder)/sdk/peering/mgmt-v2020_10_01
regenerate-manager: true
generate-interface: true
```

### Tag: package-2020-04-01 and java

These settings apply only when `--tag=package-2020-04-01 --java` is specified on the command line.
Please also specify `--azure-libraries-for-java=<path to the root directory of your azure-sdk-for-java clone>`.

``` yaml $(tag) == 'package-2020-04-01' && $(java) && $(multiapi)
java:
  namespace: com.microsoft.azure.management.peering.v2020_04_01
  output-folder: $(azure-libraries-for-java-folder)/sdk/peering/mgmt-v2020_04_01
regenerate-manager: true
generate-interface: true
```

### Tag: package-2020-01-01-preview and java

These settings apply only when `--tag=package-2020-01-01-preview --java` is specified on the command line.
Please also specify `--azure-libraries-for-java=<path to the root directory of your azure-sdk-for-java clone>`.

``` yaml $(tag) == 'package-2020-01-01-preview' && $(java) && $(multiapi)
java:
  namespace: com.microsoft.azure.management.peering.v2020_01_01_preview
  output-folder: $(azure-libraries-for-java-folder)/sdk/peering/mgmt-v2020_01_01_preview
regenerate-manager: true
generate-interface: true
```

### Tag: package-2019-09-01-preview and java

These settings apply only when `--tag=package-2019-09-01-preview --java` is specified on the command line.
Please also specify `--azure-libraries-for-java=<path to the root directory of your azure-sdk-for-java clone>`.

``` yaml $(tag) == 'package-2019-09-01-preview' && $(java) && $(multiapi)
java:
  namespace: com.microsoft.azure.management.peering.v2019_09_01_preview
  output-folder: $(azure-libraries-for-java-folder)/sdk/peering/mgmt-v2019_09_01_preview
regenerate-manager: true
generate-interface: true
```

### Tag: package-2019-08-01-preview and java

These settings apply only when `--tag=package-2019-08-01-preview --java` is specified on the command line.
Please also specify `--azure-libraries-for-java=<path to the root directory of your azure-sdk-for-java clone>`.

``` yaml $(tag) == 'package-2019-08-01-preview' && $(java) && $(multiapi)
java:
  namespace: com.microsoft.azure.management.peering.v2019_08_01_preview
  output-folder: $(azure-libraries-for-java-folder)/sdk/peering/mgmt-v2019_08_01_preview
regenerate-manager: true
generate-interface: true
```
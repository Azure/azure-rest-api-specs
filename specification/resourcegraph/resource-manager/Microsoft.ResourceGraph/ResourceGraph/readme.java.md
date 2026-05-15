## Java

These settings apply only when `--java` is specified on the command line.
Please also specify `--azure-libraries-for-java-folder=<path to the root directory of your azure-libraries-for-java clone>`.

``` yaml $(java)
azure-arm: true
fluent: true
namespace: com.microsoft.azure.management.resourcegraph
license-header: MICROSOFT_MIT_NO_CODEGEN
payload-flattening-threshold: 1
output-folder: $(azure-libraries-for-java-folder)/azure-mgmt-resourcegraph
```

### Java multi-api

``` yaml $(java) && $(multiapi)
batch:
  - tag: package-2019-04
```

### Tag: package-2019-04 and java

These settings apply only when `--tag=package-2019-04 --java` is specified on the command line.
Please also specify `--azure-libraries-for-java-folder=<path to the root directory of your azure-sdk-for-java clone>`.

``` yaml $(tag) == 'package-2019-04' && $(java) && $(multiapi)
java:
  namespace: com.microsoft.azure.management.resourcegraph.v2019_04_01
  output-folder: $(azure-libraries-for-java-folder)/sdk/resourcegraph/mgmt-v2019_04_01
regenerate-manager: true
generate-interface: true
```

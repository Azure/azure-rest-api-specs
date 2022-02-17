## Java

These settings apply only when `--java` is specified on the command line.
Please also specify `--azure-libraries-for-java-folder=<path to the root directory of your azure-libraries-for-java clone>`.

``` yaml $(java)
azure-arm: true
fluent: true
namespace: com.microsoft.azure.management.adhybridhealthservice
license-header: MICROSOFT_MIT_NO_CODEGEN
payload-flattening-threshold: 1
output-folder: $(azure-libraries-for-java-folder)/azure-mgmt-adhybridhealthservice
directive:
  - rename-operation:
      from: addsService_getMetrics
      to: addsServices_getMetrics
  - rename-operation:
      from: service_getMetrics
      to: services_getMetrics
```

### Java multi-api

``` yaml $(java) && $(multiapi)
batch:
  - tag: package-2014-01
```

### Tag: package-2014-01 and java

These settings apply only when `--tag=package-2014-01 --java` is specified on the command line.
Please also specify `--azure-libraries-for-java=<path to the root directory of your azure-sdk-for-java clone>`.

``` yaml $(tag) == 'package-2014-01' && $(java) && $(multiapi)
java:
  namespace: com.microsoft.azure.management.adhybridhealthservice.v2014_01_01
  output-folder: $(azure-libraries-for-java-folder)/sdk/adhybridhealthservice/mgmt-v2014_01_01
regenerate-manager: true
generate-interface: true
```

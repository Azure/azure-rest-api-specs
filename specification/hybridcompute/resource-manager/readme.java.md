# Java HybridCompute

These settings apply only when `--java` is specified on the command line.
Please also specify `--azure-libraries-for-java-folder=<path to the root directory of your azure-libraries-for-java clone>`.

``` yaml $(java)
azure-arm: true
fluent: true
namespace: com.microsoft.azure.management.hybridcompute
license-header: MICROSOFT_MIT_NO_CODEGEN
payload-flattening-threshold: 1
output-folder: $(azure-libraries-for-java-folder)/azure-mgmt-hybridcompute

directive:
  - remove-operation: 
    - Machines_Reconnect
    - Machines_CreateOrUpdate
    - Machines_Update
```

## Java multi-api

``` yaml $(java) && $(multiapi)
batch:
  - tag: package-2019-12
```

## Tag: package-2019-12 and java

These settings apply only when `--tag=package-2019-12 --java` is specified on the command line.
Please also specify `--azure-libraries-for-java=<path to the root directory of your azure-sdk-for-java clone>`.

``` yaml $(tag) == 'package-2019-12' && $(java) && $(multiapi)
java:
  namespace: com.microsoft.azure.management.hybridcompute.v2019_12_12
  output-folder: $(azure-libraries-for-java-folder)/sdk/hybridcompute/mgmt-v2019_12_12

regenerate-manager: true
generate-interface: true
```

## Java

These settings apply only when `--java` is specified on the command line.
Please also specify `--azure-libraries-for-java-folder=<path to the root directory of your azure-libraries-for-java clone>`.

``` yaml $(java)
azure-arm: true
fluent: true
namespace: com.microsoft.azure.management.synapse
license-header: MICROSOFT_MIT_NO_CODEGEN
payload-flattening-threshold: 1
output-folder: $(azure-libraries-for-java-folder)/azure-mgmt-synapse
directive:
  - rename-operation:
      from: IntegrationRuntimeNodeIpAddress_Get
      to: IntegrationRuntimeNodeIpAddressOperation_Get
  - rename-operation:
      from: IntegrationRuntimeAuthKeys_Regenerate
      to: IntegrationRuntimeAuthKeysOperation_Regenerate
  - rename-operation:
      from: IntegrationRuntimeAuthKeys_List
      to: IntegrationRuntimeAuthKeysOperation_List
  - rename-operation:
      from: IntegrationRuntimeStatus_Get
      to: IntegrationRuntimeStatusOperation_Get
  - rename-model:
      from: SubResource
      to: EntityResource
```

### Java multi-api

``` yaml $(java) && $(multiapi)
batch:
  - tag: package-2019-06-01-preview
```

### Tag: package-2019-06-01-preview and java

These settings apply only when `--tag=package-2019-06-01-preview --java` is specified on the command line.

Please also specify `--azure-libraries-for-java=<path to the root directory of your azure-sdk-for-java clone>`.

``` yaml $(tag) == 'package-2019-06-01-preview' && $(java) && $(multiapi)
java:
  namespace: com.microsoft.azure.management.synapse.v2019_06_01_preview
  output-folder: $(azure-libraries-for-java-folder)/sdk/synapse/mgmt-v2019_06_01_preview
regenerate-manager: true
generate-interface: true
```
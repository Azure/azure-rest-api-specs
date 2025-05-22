## Java

These settings apply only when `--java` is specified on the command line.
Please also specify `--azure-libraries-for-java-folder=<path to the root directory of your azure-libraries-for-java clone>`.

``` yaml $(java)
azure-arm: true
fluent: true
namespace: com.microsoft.azure.management.dataprotection
license-header: MICROSOFT_MIT_NO_CODEGEN
payload-flattening-threshold: 1
output-folder: $(azure-libraries-for-java-folder)/azure-mgmt-dataprotection
directive:
  - from: dataprotection.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.DataProtection/backupVaults/{vaultName}"].put.parameters
    transform: >
      $.splice(5, 1);
      return $;
    reason: hide x-ms-authorization-auxiliary header
  - from: dataprotection.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.DataProtection/backupVaults/{vaultName}"].patch.parameters
    transform: >
      $.splice(5, 1);
      return $;
    reason: hide x-ms-authorization-auxiliary header
  - from: dataprotection.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.DataProtection/backupVaults/{vaultName}/backupInstances/{backupInstanceName}"].put.parameters
    transform: >
      $.splice(6, 1);
      return $;
    reason: hide x-ms-authorization-auxiliary header
  - from: dataprotection.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.DataProtection/backupVaults/{vaultName}/backupInstances/{backupInstanceName}"].delete.parameters
    transform: >
      $.splice(5, 1);
      return $;
    reason: hide x-ms-authorization-auxiliary header
  - from: dataprotection.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.DataProtection/backupVaults/{vaultName}/backupInstances/{backupInstanceName}/restore"].post.parameters
    transform: >
      $.splice(6, 1);
      return $;
    reason: hide x-ms-authorization-auxiliary header
  - from: dataprotection.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.DataProtection/backupVaults/{vaultName}/backupInstances/{backupInstanceName}/stopProtection"].post.parameters
    transform: >
      $.splice(6, 1);
      return $;
    reason: hide x-ms-authorization-auxiliary header
  - from: dataprotection.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.DataProtection/backupVaults/{vaultName}/backupInstances/{backupInstanceName}/suspendBackups"].post.parameters
    transform: >
      $.splice(6, 1);
      return $;
    reason: hide x-ms-authorization-auxiliary header
  - from: dataprotection.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.DataProtection/backupVaults/{vaultName}/backupResourceGuardProxies/{resourceGuardProxyName}/unlockDelete"].post.parameters
    transform: >
      $.splice(6, 1);
      return $;
    reason: hide x-ms-authorization-auxiliary header  
```

### Java multi-api

``` yaml $(java) && $(multiapi)
batch:
  - tag: package-2022-10-preview
  - tag: package-preview-2022-09
  - tag: package-2021-06-preview
  - tag: package-2021-02-preview
  - tag: package-2021-01
  - tag: package-2021-07
  - tag: package-2022-03
  - tag: package-2023-01
  - tag: package-2023-05
```

### Tag: package-2023-05 and java

These settings apply only when `--tag=package-2023-05 --java` is specified on the command line.
Please also specify `--azure-libraries-for-java=<path to the root directory of your azure-sdk-for-java clone>`.

``` yaml $(tag) == 'package-2023-05' && $(java) && $(multiapi)
java:
  namespace: com.microsoft.azure.management.dataprotection.v2023_05_01
  output-folder: $(azure-libraries-for-java-folder)/dataprotection/resource-manager/v2023_05_01
regenerate-manager: true
generate-interface: true
```

### Tag: package-2023-01 and java

These settings apply only when `--tag=package-2023-01 --java` is specified on the command line.
Please also specify `--azure-libraries-for-java=<path to the root directory of your azure-sdk-for-java clone>`.

``` yaml $(tag) == 'package-2023-01' && $(java) && $(multiapi)
java:
  namespace: com.microsoft.azure.management.dataprotection.v2023_01_01
  output-folder: $(azure-libraries-for-java-folder)/dataprotection/resource-manager/v2023_01_01
regenerate-manager: true
generate-interface: true
```

### Tag: package-2022-03 and java

These settings apply only when `--tag=package-2022-03 --java` is specified on the command line.
Please also specify `--azure-libraries-for-java=<path to the root directory of your azure-sdk-for-java clone>`.

``` yaml $(tag) == 'package-2022-03' && $(java) && $(multiapi)
java:
  namespace: com.microsoft.azure.management.dataprotection.v2022_03_01
  output-folder: $(azure-libraries-for-java-folder)/dataprotection/resource-manager/v2022_03_01
regenerate-manager: true
generate-interface: true
```

### Tag: package-2021-07 and java

These settings apply only when `--tag=package-2021-07 --java` is specified on the command line.
Please also specify `--azure-libraries-for-java=<path to the root directory of your azure-sdk-for-java clone>`.

``` yaml $(tag) == 'package-2021-07' && $(java) && $(multiapi)
java:
  namespace: com.microsoft.azure.management.dataprotection.v2021_07_01
  output-folder: $(azure-libraries-for-java-folder)/dataprotection/resource-manager/v2021_07_01
regenerate-manager: true
generate-interface: true
```

### Tag: package-2021-01 and java

These settings apply only when `--tag=package-2021-01 --java` is specified on the command line.
Please also specify `--azure-libraries-for-java=<path to the root directory of your azure-sdk-for-java clone>`.

``` yaml $(tag) == 'package-2021-01' && $(java) && $(multiapi)
java:
  namespace: com.microsoft.azure.management.dataprotection.v2021_01_01
  output-folder: $(azure-libraries-for-java-folder)/dataprotection/resource-manager/v2021_01_01
regenerate-manager: true
generate-interface: true
```

### Tag: package-2021-02-preview and java

These settings apply only when `--tag=package-2021-02-preview --java` is specified on the command line.
Please also specify `--azure-libraries-for-java=<path to the root directory of your azure-sdk-for-java clone>`.

``` yaml $(tag) == 'package-2021-02-preview' && $(java) && $(multiapi)
java:
  namespace: com.microsoft.azure.management.dataprotection.v2021_02_01_preview
  output-folder: $(azure-libraries-for-java-folder)/dataprotection/resource-manager/v2021_02_01_preview
regenerate-manager: true
generate-interface: true
```

### Tag: package-2021-06-preview and java

These settings apply only when `--tag=package-2021-06-preview --java` is specified on the command line.
Please also specify `--azure-libraries-for-java=<path to the root directory of your azure-sdk-for-java clone>`.

``` yaml $(tag) == 'package-2021-06-preview' && $(java) && $(multiapi)
java:
  namespace: com.microsoft.azure.management.dataprotection.v2021_06_01_preview
  output-folder: $(azure-libraries-for-java-folder)/dataprotection/resource-manager/v2021_06_01_preview
regenerate-manager: true
generate-interface: true
```

### Tag: package-2022-10-preview and java

These settings apply only when `--tag=package-2022-10-preview --java` is specified on the command line.
Please also specify `--azure-libraries-for-java=<path to the root directory of your azure-sdk-for-java clone>`.

``` yaml $(tag) == 'package-2022-10-preview' && $(java) && $(multiapi)
java:
  namespace: com.microsoft.azure.management.dataprotection.v2022_10_01_preview
  output-folder: $(azure-libraries-for-java-folder)/dataprotection/resource-manager/v2022_10_01_preview
regenerate-manager: true
generate-interface: true
```

``` yaml $(tag) == 'package-preview-2022-09' && $(java) && $(multiapi)
java:
  namespace: com.microsoft.azure.management.dataprotection.v2022_09_01_preview
  output-folder: $(azure-libraries-for-java-folder)/dataprotection/resource-manager/v2022_09_01_preview
regenerate-manager: true
generate-interface: true
```

These settings apply only when `--java` is specified on the command line.
Please also specify `--azure-libraries-for-java-folder=<path to the root directory of your azure-libraries-for-java clone>`.

``` yaml $(java)
azure-arm: true
fluent: true
namespace: com.microsoft.azure.management.managedapplication
license-header: MICROSOFT_MIT_NO_CODEGEN
payload-flattening-threshold: 1
output-folder: $(azure-libraries-for-java-folder)/azure-mgmt-managedapplication
title: ManagedApplicationManagementClient
description: "Managed Application Client"
```

### Java multi-api

Generate all API versions currently shipped for this package

``` yaml $(java) && $(multiapi)
batch:
  - tag: package-managedapplications-2021-07
```
```

### Tag: package-managedapplications-2021-07 and java

These settings apply only when `--tag=package-managedapplications-2021-07 --java` is specified on the command line.
Please also specify `--azure-libraries-for-java-folder=<path to the root directory of your azure-libraries-for-java clone>`.

``` yaml $(tag) == 'package-managedapplications-2021-07' && $(java) && $(multiapi)
java:
  namespace: com.microsoft.azure.management.managedapplications.v2021_02_01
  output-folder: $(azure-libraries-for-java-folder)/sdk/managedapplications/mgmt-v2021_07_01
regenerate-manager: true
generate-interface: true
fconfig: '{"moduleName": "ManagedApplications"}'
```
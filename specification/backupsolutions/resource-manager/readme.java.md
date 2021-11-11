## Java

These settings apply only when `--java` is specified on the command line.
Please also specify `--azure-libraries-for-java-folder=<path to the root directory of your azure-libraries-for-java clone>`.

``` yaml $(java)
azure-arm: true
fluent: true
namespace: com.microsoft.azure.management.vmwareapplication
license-header: MICROSOFT_MIT_NO_CODEGEN
payload-flattening-threshold: 1
output-folder: $(azure-libraries-for-java-folder)/azure-mgmt-vmwareapplication
title: VMwareApplicationManagementClient
description: "VMware Application Client"
```

### Java multi-api

Generate all API versions currently shipped for this package

``` yaml $(java) && $(multiapi)
batch:
  - tag: package-vmwareapplications-2021-02
```
```

### Tag: package-vmwareapplications-2021-02 and java

These settings apply only when `--tag=package-vmwareapplications-2021-02 --java` is specified on the command line.
Please also specify `--azure-libraries-for-java-folder=<path to the root directory of your azure-libraries-for-java clone>`.

``` yaml $(tag) == 'package-vmwareapplications-2021-02' && $(java) && $(multiapi)
java:
  namespace: com.microsoft.azure.management.vmwareapplications.v2021_02_01
  output-folder: $(azure-libraries-for-java-folder)/sdk/vmwareapplications/mgmt-v2021_02_01
regenerate-manager: true
generate-interface: true
fconfig: '{"moduleName": "VMwareApplications"}'
```

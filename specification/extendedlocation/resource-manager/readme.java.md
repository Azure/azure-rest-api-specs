
These settings apply only when `--java` is specified on the command line.
Please also specify `--azure-libraries-for-java-folder=<path to the root directory of your azure-libraries-for-java clone>`.

``` yaml $(java)
azure-arm: true
fluent: true
namespace: com.microsoft.azure.management.extendedlocation
license-header: MICROSOFT_MIT_NO_CODEGEN
payload-flattening-threshold: 1
output-folder: $(azure-libraries-for-java-folder)/azure-mgmt-extendedlocation
title: ExtendedLocationManagementClient
description: "Extended Location Client"
```

### Java multi-api

``` yaml $(java) && $(multiapi)
batch:
  - tag: package-2020-10-01-privatepreview
```

### Tag: package-2020-10-01-privatepreview and java

These settings apply only when `--tag=package-2020-10-01-privatepreview` is specified on the command line.
Please also specify `--azure-libraries-for-java-folder=<path to the root directory of your azure-sdk-for-java clone>`.

``` yaml $(tag) == 'package-2020-10-01-privatepreview' && $(java) && $(multiapi)
java:
  namespace: com.microsoft.azure.management.extendedlocation.v2020_10_01_privatepreview
  output-folder: $(azure-libraries-for-java-folder)/extendedlocation/resource-manager/v2020_10_01_privatepreview
regenerate-manager: true
generate-interface: true
```
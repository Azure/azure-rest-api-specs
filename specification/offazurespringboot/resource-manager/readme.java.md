
These settings apply only when `--java` is specified on the command line.
Please also specify `--azure-libraries-for-java-folder=<path to the root directory of your azure-libraries-for-java clone>`.

``` yaml $(java)
azure-arm: true
fluent: true
namespace: com.azure.resourcemanager.springappdiscovery
license-header: MICROSOFT_MIT_NO_CODEGEN
payload-flattening-threshold: 1
output-folder: $(azure-libraries-for-java-folder)/azure-resourcemanager-springappdiscovery
title: SpringAppsDiscoveryClient
description: "Spring App Discovery Client"
```


### Java multi-api

``` yaml $(java) && $(multiapi)
batch:
  - tag: package-2023-01-01-preview
```

### Tag: package-2023-01-01-preview and java

These settings apply only when `--tag=package-2023-01-01-preview` is specified on the command line.
Please also specify `--azure-libraries-for-java-folder=<path to the root directory of your azure-sdk-for-java clone>`.

``` yaml $(tag) == 'package-2023-01-01-preview' && $(java) && $(multiapi)
java:
  namespace: com.azure.resourcemanager.springappdiscovery.v2023-01-01-preview
  output-folder: $(azure-libraries-for-java-folder)/springappdiscovery/resource-manager/v2023-01-01-preview
regenerate-manager: true
generate-interface: true
```
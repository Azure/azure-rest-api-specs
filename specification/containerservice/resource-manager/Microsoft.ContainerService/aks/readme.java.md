## Java

These settings apply only when `--java` is specified on the command line and `--tag=profile-hybrid-2020-09-01` is not specified.
Please also specify `--azure-libraries-for-java-folder=<path to the root directory of your azure-libraries-for-java clone>`.

``` yaml $(java)
title: ContainerServiceManagementClient
description: "Container Service Client"
modelerfour:
  lenient-model-deduplication: true
preserve-model: ContainerServiceVMSizeTypes
rename-model: Ossku:OSSku
enable-sync-stack: false
directive:
  from: managedClusters.json
  where: "$.definitions.TrustedAccessRoleRule.properties.nonResourceURLs"
  transform: >
    $["x-ms-client-name"] = "nonResourceUrls";
```
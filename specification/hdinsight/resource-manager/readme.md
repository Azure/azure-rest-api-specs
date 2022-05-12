# HDInsight

> see https://aka.ms/autorest

This is the AutoRest configuration file for HDInsight.



---
## Getting Started
To build the SDK for HDInsight, simply [Install AutoRest](https://aka.ms/autorest/install) and in this folder, run:

> `autorest`

To see additional help and options, run:

> `autorest --help`
---

## Configuration



### Basic Information
These are the global settings for the HDInsight API.

``` yaml
title: HDInsightManagementClient
description: HDInsight Management Client
openapi-type: arm
azure-arm: true
tag: package-2021-06
```

### Suppression
``` yaml
directive:
  - suppress: DefinitionsPropertiesNamesCamelCase
    reason: This would require a breaking change, and need to be consistent with the response from RP side.
    from: Microsoft.HDInsight/preview/2015-03-01-preview/locations.json
    where:
      - $.definitions.CapabilitiesResult.properties.vmsize_filters
      - $.definitions.RegionalQuotaCapability.properties.cores_available
      - $.definitions.RegionalQuotaCapability.properties.cores_used
      - $.definitions.RegionalQuotaCapability.properties.region_name
      - $.definitions.QuotaCapability.properties.cores_used
      - $.definitions.QuotaCapability.properties.max_cores_allowed
      - $.definitions.VmSizeCompatibilityFilter.properties.ClusterVersions
      - $.definitions.VmSizeCompatibilityFilter.properties.NodeTypes
      - $.definitions.VmSizeCompatibilityFilter.properties.ClusterFlavors
      - $.definitions.VmSizeCompatibilityFilter.properties.Regions
      - $.definitions.VmSizeCompatibilityFilter.properties.FilterMode
      - $.definitions.VmSizeCompatibilityFilter.properties.OsType
      - $.definitions.VmSizeCompatibilityFilter.properties.VMSizes
      - $.definitions.VmSizeCompatibilityFilter.properties.ESPApplied
      - $.definitions.VmSizeCompatibilityFilter.properties.ComputeIsolationSupported
```
 
``` yaml
directive:
  - suppress: DefinitionsPropertiesNamesCamelCase
    reason: This would require a breaking change, and need to be consistent with the response from RP side.
    from: Microsoft.HDInsight/stable/2018-06-01-preview/locations.json
    where:
      - $.definitions.CapabilitiesResult.properties.vmsize_filters
      - $.definitions.RegionalQuotaCapability.properties.cores_available
      - $.definitions.RegionalQuotaCapability.properties.cores_used
      - $.definitions.RegionalQuotaCapability.properties.region_name
      - $.definitions.QuotaCapability.properties.cores_used
      - $.definitions.QuotaCapability.properties.max_cores_allowed
      - $.definitions.VmSizeCompatibilityFilter.properties.ClusterVersions
      - $.definitions.VmSizeCompatibilityFilter.properties.NodeTypes
      - $.definitions.VmSizeCompatibilityFilter.properties.ClusterFlavors
      - $.definitions.VmSizeCompatibilityFilter.properties.Regions
      - $.definitions.VmSizeCompatibilityFilter.properties.FilterMode
      - $.definitions.VmSizeCompatibilityFilter.properties.OsType
      - $.definitions.VmSizeCompatibilityFilter.properties.VMSizes
      - $.definitions.VmSizeCompatibilityFilter.properties.ESPApplied
      - $.definitions.VmSizeCompatibilityFilter.properties.ComputeIsolationSupported
```

``` yaml
directive:
  - suppress: DefinitionsPropertiesNamesCamelCase
    reason: This would require a breaking change, and need to be consistent with the response from RP side.
    from: 
      - Microsoft.HDInsight/stable/2018-06-01-preview/cluster.json
      - Microsoft.HDInsight/preview/2015-03-01-preview/cluster.json
      - Microsoft.HDInsight/stable/2021-06-01/cluster.json
    where:
      - $.definitions.Role.properties.VMGroupName
```

``` yaml
directive:
  - suppress: R3016 # to suppress (DefinitionsPropertiesNamesCamelCase)
    from: cluster.json
    reason: The casing of this property is not incorrect.
    where:
      - $..["restAuthCredential.isEnabled"]
      - $..["restAuthCredential.username"]
      - $..["restAuthCredential.password"]
```

``` yaml
directive:
  - suppress: R4007 # to suppress (DefaultErrorResponseSchema)
    reason: Update the default error response to a new format would be a braking change for service.
```

### Tag: package-2021-06

These settings apply only when `--tag=package-2021-06` is specified on the command line.

``` yaml $(tag) == 'package-2021-06'
input-file:
- Microsoft.HDInsight/stable/2021-06-01/cluster.json
- Microsoft.HDInsight/stable/2021-06-01/applications.json
- Microsoft.HDInsight/stable/2021-06-01/locations.json
- Microsoft.HDInsight/stable/2021-06-01/configurations.json
- Microsoft.HDInsight/stable/2021-06-01/extensions.json
- Microsoft.HDInsight/stable/2021-06-01/scriptActions.json
- Microsoft.HDInsight/stable/2021-06-01/operations.json
- Microsoft.HDInsight/stable/2021-06-01/virtualMachines.json
- Microsoft.HDInsight/stable/2021-06-01/privateEndpointConnections.json
- Microsoft.HDInsight/stable/2021-06-01/privateLinkResources.json
```


### Tag: package-2018-06-preview

These settings apply only when `--tag=package-2018-06-preview` is specified on the command line.

``` yaml $(tag) == 'package-2018-06-preview'
input-file:
- Microsoft.HDInsight/stable/2018-06-01-preview/cluster.json
- Microsoft.HDInsight/stable/2018-06-01-preview/applications.json
- Microsoft.HDInsight/stable/2018-06-01-preview/locations.json
- Microsoft.HDInsight/stable/2018-06-01-preview/configurations.json
- Microsoft.HDInsight/stable/2018-06-01-preview/extensions.json
- Microsoft.HDInsight/stable/2018-06-01-preview/scriptActions.json
- Microsoft.HDInsight/stable/2018-06-01-preview/operations.json
- Microsoft.HDInsight/stable/2018-06-01-preview/virtualMachines.json
```


### Tag: package-2015-03-preview

These settings apply only when `--tag=package-2015-03-preview` is specified on the command line.

``` yaml $(tag) == 'package-2015-03-preview'
input-file:
- Microsoft.HDInsight/preview/2015-03-01-preview/cluster.json
- Microsoft.HDInsight/preview/2015-03-01-preview/applications.json
- Microsoft.HDInsight/preview/2015-03-01-preview/locations.json
- Microsoft.HDInsight/preview/2015-03-01-preview/configurations.json
- Microsoft.HDInsight/preview/2015-03-01-preview/extensions.json
- Microsoft.HDInsight/preview/2015-03-01-preview/scriptActions.json
- Microsoft.HDInsight/preview/2015-03-01-preview/operations.json
- Microsoft.HDInsight/preview/2015-03-01-preview/virtualMachines.json
```


---
# Code Generation


## Swagger to SDK

This section describes what SDK should be generated by the automatic system.
This is not used by Autorest itself.

``` yaml $(swagger-to-sdk)
swagger-to-sdk:
  - repo: azure-sdk-for-net
  - repo: azure-sdk-for-go
  - repo: azure-sdk-for-go-track2
  - repo: azure-sdk-for-java
  - repo: azure-sdk-for-python-track2
  - repo: azure-sdk-for-js
  - repo: azure-sdk-for-node
  - repo: azure-resource-manager-schemas
  - repo: azure-powershell
```

## Python

See configuration in [readme.python.md](./readme.python.md)

## Go

See configuration in [readme.go.md](./readme.go.md)

## C#

These settings apply only when `--csharp` is specified on the command line.
Please also specify `--csharp-sdks-folder=<path to "SDKs" directory of your azure-sdk-for-net clone>`.

``` yaml $(csharp)
csharp:
  license-header: MICROSOFT_MIT_NO_VERSION
  namespace: Microsoft.Azure.Management.HDInsight
  output-folder: $(csharp-sdks-folder)/hdinsight/Microsoft.Azure.Management.HDInsight/src/Generated
  clear-output-folder: true
```


## Java

These settings apply only when `--java` is specified on the command line.
Please also specify `--azure-libraries-for-java-folder=<path to the root directory of your azure-libraries-for-java clone>`.

``` yaml $(java)
azure-arm: true
fluent: true
namespace: com.microsoft.azure.management.hdinsight
license-header: MICROSOFT_MIT_NO_CODEGEN
payload-flattening-threshold: 1
output-folder: $(azure-libraries-for-java-folder)/azure-mgmt-hdinsight
```

### Java multi-api

``` yaml $(java) && $(multiapi)
batch:
  - tag: package-2018-06-preview
  - tag: package-2015-03-preview
```


### Tag: package-2018-06-preview and java

These settings apply only when `--tag=package-2015-03-preview --java` is specified on the command line.
Please also specify `--azure-libraries-for-java=<path to the root directory of your azure-sdk-for-java clone>`.

``` yaml $(tag) == 'package-2018-06-preview' && $(java) && $(multiapi)
java:
  namespace: com.microsoft.azure.management.hdinsight.v2018_06_01_preview
  output-folder: $(azure-libraries-for-java-folder)/sdk/hdinsight/mgmt-v2018_06_01_preview
regenerate-manager: true
generate-interface: true
```


### Tag: package-2015-03-preview and java

These settings apply only when `--tag=package-2015-03-preview --java` is specified on the command line.
Please also specify `--azure-libraries-for-java=<path to the root directory of your azure-sdk-for-java clone>`.

``` yaml $(tag) == 'package-2015-03-preview' && $(java) && $(multiapi)
java:
  namespace: com.microsoft.azure.management.hdinsight.v2015_03_01_preview
  output-folder: $(azure-libraries-for-java-folder)/sdk/hdinsight/mgmt-v2015_03_01_preview
regenerate-manager: true
generate-interface: true
```






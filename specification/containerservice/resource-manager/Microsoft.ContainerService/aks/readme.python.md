## Python

These settings apply only when `--python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(python)
title: ContainerServiceClient
azure-arm: true
license-header: MICROSOFT_MIT_NO_VERSION
package-name: azure-mgmt-containerservice
namespace: azure.mgmt.containerservice
package-version: 1.0.0b1
clear-output-folder: true
```

``` yaml $(python)
no-namespace-folders: true
output-folder: $(python-sdks-folder)/containerservice/azure-mgmt-containerservice/azure/mgmt/containerservice
```

``` yaml $(python)
directive:
  - from: swagger-document
    where: $.definitions.ManagedClusterLoadBalancerProfile.properties.managedOutboundIPs.properties["countIPv6"]
    transform: $["x-ms-client-name"] = "count_ipv6"
```
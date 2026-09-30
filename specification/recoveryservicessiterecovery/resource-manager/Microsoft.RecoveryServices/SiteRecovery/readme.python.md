## Python

These settings apply only when `--python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(python)
azure-arm: true
license-header: MICROSOFT_MIT_NO_VERSION
namespace: azure.mgmt.recoveryservicessiterecovery
package-name: azure-mgmt-recoveryservicessiterecovery
package-version: 1.0.0b1
clear-output-folder: true
```

``` yaml $(python)
no-namespace-folders: true
output-folder: $(python-sdks-folder)/recoveryservices/azure-mgmt-recoveryservicessiterecovery/azure/mgmt/recoveryservicessiterecovery
```

``` yaml $(python)
directive: 
- from: swagger-document
  where: $.parameters.ResourceGroupName
  transform: >
    $["x-ms-parameter-location"] = "client"; 

- from: swagger-document
  where: $.parameters.ResourceName
  transform: >
    $["x-ms-parameter-location"] = "client";

- from: swagger-document
  where: $.parameters.FabricName
  transform: >
    $["x-ms-parameter-location"] = "method";

- from: swagger-document
  where: $.parameters.ProtectionContainerName
  transform: >
    $["x-ms-parameter-location"] = "method";

- from: swagger-document
  where: $.parameters.ReplicationProtectionClusterName
  transform: >
    $["x-ms-parameter-location"] = "method";
```

## Python

These settings apply only when `--python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(python)
title: SecurityCenter
azure-arm: true
license-header: MICROSOFT_MIT_NO_VERSION
package-name: azure-mgmt-security
namespace: azure.mgmt.security
package-version: 1.0.0b1
clear-output-folder: true
```

``` yaml $(python)
no-namespace-folders: true
output-folder: $(python-sdks-folder)/security/azure-mgmt-security/azure/mgmt/security
modelerfour:
  lenient-model-deduplication: true
directive:
  - from: swagger-document
    where: $.definitions.AadConnectivityState.properties.connectivityState
    transform: > 
        $['x-ms-enum']['name'] = 'AadConnectivityStateEnum';
  - from: swagger-document
    where: $.definitions.ExternalSecuritySolutionKind.properties.kind
    transform: > 
        $['x-ms-enum']['name'] = 'ExternalSecuritySolutionKindEnum';
  - from: jitNetworkAccessPolicies.json
    where: $.definitions.JitNetworkAccessPortRule.properties.protocol
    transform: > 
        $['x-ms-enum']['name'] = 'protocolEnum';
  - from: alerts.json
    where: $.definitions.AlertSimulatorRequestProperties.properties.kind
    transform: > 
        $['x-ms-enum']['name'] = 'kindEnum';
```


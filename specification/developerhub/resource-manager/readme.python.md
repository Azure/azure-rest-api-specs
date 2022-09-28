## Python

These settings apply only when `--python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(python)
title: DevHubMgmtClient
azure-arm: true
license-header: MICROSOFT_MIT_NO_VERSION
package-name: azure-mgmt-devhub
namespace: azure.mgmt.devhub
package-version: 1.0.0b1
clear-output-folder: true

directive:
  - from: swagger-document
    where: $.parameters.GitHubOAuthCodeParameter
    transform: >
      $['x-ms-parameter-location'] = "method";

  - from: swagger-document
    where: $.parameters.GitHubOAuthStateParameter
    transform: >
      $['x-ms-parameter-location'] = "method";
      
  - from: swagger-document
    where: $.parameters.ManagedClusterParameter
    transform: >
      $['x-ms-parameter-location'] = "method";
```

``` yaml $(python)
no-namespace-folders: true
output-folder: $(python-sdks-folder)/devhub/azure-mgmt-devhub/azure/mgmt/devhub
```

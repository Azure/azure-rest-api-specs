## Python

These settings apply only when `--python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(python)
azure-arm: true
license-header: MICROSOFT_MIT_NO_VERSION
package-name: azure-mgmt-sreagent
namespace: azure.mgmt.sreagent
package-version: 1.0.0b1
clear-output-folder: true
```

``` yaml $(python)
no-namespace-folders: true
output-folder: $(python-sdks-folder)/sreagent/azure-mgmt-sreagent/azure/mgmt/sreagent
modelerfour:
  lenient-model-deduplication: true # !!temporary!! to solve the duplicate schema issue of ErrorResponse in common-types v2 and v3 introduced in this PR https://github.com/Azure/azure-rest-api-specs/pull/27786
```


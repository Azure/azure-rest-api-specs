## Python

These settings apply only when `--python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(python) && $(track2)
azure-arm: true
license-header: MICROSOFT_MIT_NO_VERSION
namespace: azure.mgmt.recoveryservicessiterecovery
package-name: azure-mgmt-recoveryservicessiterecovery
package-version: 1.0.0b1
clear-output-folder: true
```

``` yaml $(python) && $(python-mode) == 'update' && $(track2)
no-namespace-folders: true
output-folder: $(python-sdks-folder)/recoveryservices/azure-mgmt-recoveryservicessiterecovery/azure/mgmt/recoveryservicessiterecovery
```

``` yaml $(python) && $(python-mode) == 'create' && $(track2)
basic-setup-py: true
output-folder: $(python-sdks-folder)/recoveryservices/azure-mgmt-recoveryservicessiterecovery
```

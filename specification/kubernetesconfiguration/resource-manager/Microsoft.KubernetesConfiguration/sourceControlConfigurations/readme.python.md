## Python

These settings apply only when `--python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.
Use `--python-mode=update` if you already have a setup.py and just want to update the code itself.

``` yaml $(python)
azure-arm: true
license-header: MICROSOFT_MIT_NO_VERSION
namespace: azure.mgmt.kubernetesconfiguration.sourcecontrolconfiguration
package-name: azure-mgmt-kubernetesconfiguration-sourcecontrolconfiguration
no-namespace-folders: true
package-version: 1.1.0
clear-output-folder: true
output-folder: $(python-sdks-folder)/kubernetesconfiguration/azure-mgmt-kubernetesconfiguration/azure/mgmt/sourcecontrolconfiguration/
perform-load: false
```

### Tag: package-2024-11 and python

These settings apply only when `--tag=package-2024-11 --python` is specified on the command line.

``` yaml $(tag) == 'package-2024-11'
namespace: azure.mgmt.kubernetesconfiguration.sourcecontrolconfiguration.v2024_11_01
output-folder: $(python-sdks-folder)/kubernetesconfiguration/azure-mgmt-kubernetesconfiguration/azure/mgmt/sourcecontrolconfiguration/v2024_11_01
```


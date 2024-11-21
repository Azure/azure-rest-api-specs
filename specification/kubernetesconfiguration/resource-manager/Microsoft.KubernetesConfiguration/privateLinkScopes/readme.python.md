## Python

These settings apply only when `--python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.
Use `--python-mode=update` if you already have a setup.py and just want to update the code itself.

``` yaml $(python)
azure-arm: true
license-header: MICROSOFT_MIT_NO_VERSION
namespace: azure.mgmt.kubernetesconfiguration.privatelinkscopes
package-name: azure-mgmt-kubernetesconfiguration-privatelinkscopes
no-namespace-folders: true
package-version: 1.1.0
clear-output-folder: true
```

### Tag: package-preview-2024-11-only and python

These settings apply only when `--tag=package-preview-2024-11-only --python` is specified on the command line.

``` yaml $(tag) == 'package-preview-2024-11-only'
namespace: azure.mgmt.kubernetesconfiguration.privatelinkscopes.v2024_11_01_preview
output-folder: $(python-sdks-folder)/kubernetesconfiguration/azure-mgmt-kubernetesconfiguration-privatelinkscopes/azure/mgmt/v2024_04_01_preview
```


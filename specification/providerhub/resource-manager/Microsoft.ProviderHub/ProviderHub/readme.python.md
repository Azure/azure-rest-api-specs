## Python

These settings apply only when `--python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.
Use `--python-mode=update` if you already have a setup.py and just want to update the code itself.
These settings apply only when `--track2` is specified on the command line.

```yaml $(python)
azure-arm: true
license-header: MICROSOFT_MIT_NO_VERSION
namespace: azure.mgmt.providerhub
package-name: azure-mgmt-providerhub
package-version: 1.0.0
clear-output-folder: true
modelerfour:
    lenient-model-deduplication: true
```

``` yaml $(python)
no-namespace-folders: true
output-folder: $(python-sdks-folder)/providerhub/azure-mgmt-providerhub/azure/mgmt/providerhub
```
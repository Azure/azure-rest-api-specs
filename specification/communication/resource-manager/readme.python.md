## Python

These settings apply only when `--python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.
Use `--python-mode=update` if you already have a setup.py and just want to update the code itself.
These settings apply only when `--track2` is specified on the command line.

``` yaml $(python)
azure-arm: true
license-header: MICROSOFT_MIT_NO_VERSION
package-name: azure-mgmt-communication
namespace: azure.mgmt.communication
package-version: 1.0.0
```

```yaml $(python)
no-namespace-folders: true
output-folder: $(python-sdks-folder)/communication/azure-mgmt-communication/azure/mgmt/communication
```


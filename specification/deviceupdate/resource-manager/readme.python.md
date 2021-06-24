## Python

These settings apply only when `--python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

```yaml $(python) && $(track2)
azure-arm: true
license-header: MICROSOFT_MIT_NO_VERSION
package-name: azure-mgmt-deviceupdate
package-version: 1.0.0b1
no-namespace-folders: true
```

```yaml $(python) && $(track2) && $(python-mode) == 'update'
no-namespace-folders: true
output-folder: $(python-sdks-folder)/deviceupdate/azure-mgmt-deviceupdate/azure/mgmt/deviceupdate
```

```yaml $(python) && $(track2) && $(python-mode) == 'create'
basic-setup-py: true
output-folder: $(python-sdks-folder)/deviceupdate/azure-mgmt-deviceupdate
```

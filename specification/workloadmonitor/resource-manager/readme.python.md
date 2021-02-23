## Python

These settings apply only when `--python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.
Use `--python-mode=update` if you already have a setup.py and just want to update the code itself.

```yaml !$(track2)
python-mode: create
python:
  azure-arm: true
  license-header: MICROSOFT_MIT_NO_VERSION
  payload-flattening-threshold: 2
  namespace: azure.mgmt.workloadmonitor
  package-name: azure-mgmt-workloadmonitor
  package-version: 1.0.0
  clear-output-folder: true
```

These settings apply only when `--track2` is specified on the command line.

``` yaml $(track2)
azure-arm: true
license-header: MICROSOFT_MIT_NO_VERSION
package-name: azure-mgmt-workloadmonitor
no-namespace-folders: true
package-version: 1.0.0
```

``` yaml $(python) && $(python-mode) == 'update'
python:
  no-namespace-folders: true
  output-folder: $(python-sdks-folder)/workloadmonitor/azure-mgmt-workloadmonitor/azure/mgmt/workloadmonitor
no-namespace-folders: true
output-folder: $(python-sdks-folder)/workloadmonitor/azure-mgmt-workloadmonitor/azure/mgmt/workloadmonitor
```

``` yaml $(python) && $(python-mode) == 'create'
python:
  basic-setup-py: true
  output-folder: $(python-sdks-folder)/workloadmonitor/azure-mgmt-workloadmonitor
basic-setup-py: true
output-folder: $(python-sdks-folder)/workloadmonitor/azure-mgmt-workloadmonitor
```

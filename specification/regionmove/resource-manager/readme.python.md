## Python

These settings apply only when `--python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

```yaml $(python) && !$(track2)
python:
  azure-arm: true
  license-header: MICROSOFT_MIT_NO_VERSION
  payload-flattening-threshold: 2
  namespace: azure.mgmt.regionmove
  package-name: azure-mgmt-regionmove
  package-version: 0.1.0-preview
  clear-output-folder: true
```

```yaml $(python) && $(track2)
azure-arm: true 
license-header: MICROSOFT_MIT_NO_VERSION
package-name: azure-mgmt-regionmove
clear-output-folder: true
no-namespace-folders: true
package-version: 0.1.0-preview
```

```yaml $(python) && $(python-mode) == 'update'
no-namespace-folders: true
output-folder: $(python-sdks-folder)/regionmove/azure-mgmt-regionmove/azure/mgmt/regionmove
```

``` yaml $(python) && $(python-mode) == 'create'
python:
  basic-setup-py: true 
  output-folder: $(python-sdks-folder)/regionmove/azure-mgmt-regionmove
```

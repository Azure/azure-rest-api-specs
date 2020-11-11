## Python

These settings apply only when `--python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

```yaml $(python) && !$(track2)
python:
  azure-arm: true
  license-header: MICROSOFT_MIT_NO_VERSION
  payload-flattening-threshold: 2
  namespace: azure.mgmt.migrate
  package-name: azure-mgmt-migrate
  package-version: 0.1.0-preview
  clear-output-folder: true
```

```yaml $(python) && $(track2)
azure-arm: true 
license-header: MICROSOFT_MIT_NO_VERSION
package-name: azure-mgmt-migrate
clear-output-folder: true
no-namespace-folders: true
package-version: 0.1.0-preview
```

```yaml $(python) && $(python-mode) == 'update' && $(track2)
no-namespace-folders: true
output-folder: $(python-sdks-folder)/migrate/azure-mgmt-migrate/azure/mgmt/migrate
```

``` yaml $(python) && $(python-mode) == 'create' && $(track2)
python:
  basic-setup-py: true 
  output-folder: $(python-sdks-folder)/migrate/azure-mgmt-migrate
```

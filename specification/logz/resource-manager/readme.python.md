## Python

These settings apply only when `--python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

```yaml $(python)
python-mode: create
python:
  azure-arm: true
  license-header: MICROSOFT_MIT_NO_VERSION
  payload-flattening-threshold: 2
  namespace: azure.mgmt.logz
  package-name: azure-mgmt-logz
  package-version: 2020-10-01-preview
  clear-output-folder: true
```

``` yaml $(python) && $(python-mode) == 'update'
python:
  no-namespace-folders: true
  output-folder: $(python-sdks-folder)/azure-mgmt-logz/azure/mgmt/logz
```

``` yaml $(python) && $(python-mode) == 'create'
python:
  basic-setup-py: true
  output-folder: $(python-sdks-folder)/azure-mgmt-logz
```

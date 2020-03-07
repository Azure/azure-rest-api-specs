## Python

These settings apply only when `--python` is specified on the command line.
``` yaml $(python)

python:
  license-header: MICROSOFT_MIT_NO_VERSION
  package-name: azure-mgmt-datafactory
  clear-output-folder: true
```

``` yaml $(python) && $(python-mode) == 'update'
python:
  no-namespace-folders: true
  output-folder: $(python-sdks-folder)/datafactory/azure-mgmt-datafactory/azure/mgmt/datafactory
```
``` yaml $(python) && $(python-mode) == 'create'
python:
  basic-setup-py: true
  output-folder: $(python-sdks-folder)/datafactory/azure-mgmt-datafactory
```
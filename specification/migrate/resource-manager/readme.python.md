## Python

These settings apply only when `--python` is specified on the command line.
``` yaml $(python)

python:
  license-header: MICROSOFT_MIT_NO_VERSION
  payload-flattening-threshold: 2
  package-name: azure-mgmt-migrate
  clear-output-folder: true
add-credential: true
```

``` yaml $(python) && $(python-mode) == 'update'
python:
  no-namespace-folders: true
  output-folder: $(python-sdks-folder)/migrate/azure-mgmt-migrate/azure/mgmt/migrate
```
``` yaml $(python) && $(python-mode) == 'create'
python:
  basic-setup-py: true
  output-folder: $(python-sdks-folder)/migrate/azure-mgmt-migrate
```
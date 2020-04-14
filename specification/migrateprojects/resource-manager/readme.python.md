## Python

These settings apply only when `--python` is specified on the command line.
``` yaml $(python)

python:
  license-header: MICROSOFT_MIT_NO_VERSION
  payload-flattening-threshold: 2
  package-name: azure-mgmt-migrateprojects
  #clear-output-folder: true
```

``` yaml $(python) && $(python-mode) == 'update'
python:
  no-namespace-folders: true
  output-folder: $(python-sdks-folder)/migrateprojects/azure-mgmt-migrateprojects/azure/mgmt/migrateprojects
```
``` yaml $(python) && $(python-mode) == 'create'
python:
  basic-setup-py: true
  output-folder: $(python-sdks-folder)/migrateprojects/azure-mgmt-migrateprojects
```
## Python

These settings apply only when `--python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

```yaml $(python)
python:
  azure-arm: true
  license-header: MICROSOFT_MIT_NO_VERSION
  payload-flattening-threshold: 2
  namespace: azure.mgmt.mpcnetworkfunction
  package-name: azure-mgmt-mpcnetworkfunction
  package-version: 2023-10-15
  clear-output-folder: true
```

```yaml $(python)
python:
  azure-arm: true
  license-header: MICROSOFT_MIT_NO_VERSION
  payload-flattening-threshold: 2
  namespace: azure.mgmt.mpcnetworkfunction
  package-name: azure-mgmt-mpcnetworkfunction
  package-version: 2023-05-15-preview
  clear-output-folder: true
```

```yaml $(python)
python:
  no-namespace-folders: true
  output-folder: $(python-sdks-folder)/mpcnetworkfunction/azure-mgmt-mpcnetworkfunction/azure/mgmt/mpcnetworkfunction
```

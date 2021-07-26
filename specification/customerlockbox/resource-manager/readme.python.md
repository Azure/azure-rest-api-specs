## Python

These settings apply only when `--python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

```yaml $(python)
python:
  azure-arm: true
  license-header: MICROSOFT_MIT_NO_VERSION
  payload-flattening-threshold: 2
  namespace: azure.mgmt.customerlockbox
  package-name: azure-mgmt-customerlockbox
  package-version: 2018-02-28-preview
  clear-output-folder: true
```

```yaml $(python)
python:
  no-namespace-folders: true
  output-folder: $(python-sdks-folder)/customerlockbox/azure-mgmt-customerlockbox/azure/mgmt/customerlockbox
```

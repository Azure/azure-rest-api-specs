## Python

These settings apply only when `--python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

```yaml $(python)
python:
  azure-arm: true
  license-header: MICROSOFT_MIT_NO_VERSION
  payload-flattening-threshold: 2
  namespace: microsoft.confidentialledger
  package-name: azure-mgmt-confidentialledger
  package-version: 0.0.1
  clear-output-folder: true
```

```yaml $(python)
python:
  no-namespace-folders: true
  output-folder: $(python-sdks-folder)/confidentialledger/azure-mgmt-confidentialledger/azure/mgmt/confidentialledger
```

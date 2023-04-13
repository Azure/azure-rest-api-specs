## Python

These settings apply only when `--python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

```yaml $(python)
python:
  azure-arm: true
  license-header: MICROSOFT_MIT_NO_VERSION
  payload-flattening-threshold: 2
  no-namespace-folders: true
  clear-output-folder: true
  namespace: Microsoft.Azure.IotCentral
  package-name: iotcentral
  package-version: "2.0.0"
  output-folder: $(python-sdks-folder)/2.0.0
```
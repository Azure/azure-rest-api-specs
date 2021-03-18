## Python

These settings apply only when `--python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

```yaml $(python)
python:
  license-header: MICROSOFT_MIT_NO_VERSION
  namespace: azure.maps
  package-name: azure-maps
  package-version: 1.0-preview
  clear-output-folder: true
  no-namespace-folders: true
  enable-xml: true
  vanilla: true
  output-folder: $(python-sdks-folder)/maps
```
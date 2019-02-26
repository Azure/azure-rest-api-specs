## Python

These settings apply only when `--python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.
Use `--python-mode=update` if you already have a setup.py and just want to update the code itself.

``` yaml $(python)
python-mode: create
python:
  azure-arm: true
  license-header: MICROSOFT_MIT_NO_VERSION
  payload-flattening-threshold: 2
  namespace: azure.mgmt.security
  package-name: azure-mgmt-security
  package-version: 1.0.0
  clear-output-folder: true
```

``` yaml $(python) && $(python-mode) == 'update'
python:
  no-namespace-folders: true
  output-folder: $(python-sdks-folder)/azure-mgmt-security/azure/mgmt/security
```

``` yaml $(python) && $(python-mode) == 'create'
python:
  basic-setup-py: true
  output-folder: $(python-sdks-folder)/azure-mgmt-security
```

### Python multi-api

Generate all API versions currently shipped for this package

```yaml $(python) && $(multiapi)
batch:
  - tag: package-composite-v1
  - tag: package-composite-v2
```

### Tag: package-composite-v1-only and python

These settings apply only when `--tag=package-composite-v1-only --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-composite-v1-only' && $(python)
python:
  namespace: azure.mgmt.security.composite-v1
  output-folder: $(python-sdks-folder)/azure-mgmt-security/azure/mgmt/security/composite-v1
```

### Tag: package-composite-v2-only and python

These settings apply only when `--tag=package-composite-v2-only --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-composite-v2-only' && $(python)
python:
  namespace: azure.mgmt.security.composite-v2
  output-folder: $(python-sdks-folder)/azure-mgmt-security/azure/mgmt/security/composite-v2
```
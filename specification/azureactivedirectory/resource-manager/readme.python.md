## Python

These settings apply only when `--python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

```yaml $(python)
python:
  azure-arm: true
  license-header: MICROSOFT_MIT_NO_VERSION
  payload-flattening-threshold: 2
  namespace: Microsoft.Aadiam
  package-name: azure-mgmt-azureactivedirectory
  clear-output-folder: true
  no-namespace-folders: true
  python-base-folder: azureactivedirectory/azure-mgmt-azureactivedirectory/azureactivedirectory
  python-base-namespace: azureactivedirectory
```

### Python multi-api

Generate all API versions currently shipped for this package

```yaml $(python) && $(multiapi)
batch:
  - tag: package-2017-04-01-only
  - tag: package-2018-01-01-only
```

### Tag: package-2017-04-01-only and python

These settings apply only when `--tag=package-2017-04-01-only --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-2017-04-01-only' && $(python)
python:
  namespace: $(python-base-namespace).v2017_04_01
  output-folder: $(python-sdks-folder)/$(python-base-folder)/v2017_04_01
```

### Tag: package-2018-01-01-only and python

These settings apply only when `--tag=package-2018-01-01-only --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-2018-01-01-only' && $(python)
python:
  namespace: $(python-base-namespace).v2018_01_01
  output-folder: $(python-sdks-folder)/$(python-base-folder)/v2018_01_01
```
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
  package-name: azure-mgmt-azure-ad-b2c
  clear-output-folder: true
  no-namespace-folders: true
```

### Python multi-api

Generate all API versions currently shipped for this package

```yaml $(python) && $(multiapi)
batch:
  - tag: package-2020-05-01-preview
  - tag: package-2019-01-01-preview
```

### Tag: package-2019-01-01-preview and go

These settings apply only when `--tag=package-2019-01-01-preview --python` is specified on the command line.

```yaml $(python)
python:
  namespace: azure.mgmt.azureadb2c.v2019_01_01
  output-folder: $(python-sdks-folder)/azureadb2c/azure-mgmt-azureadb2c/azure/mgmt/azureadb2c/v2020_05_01
```

### Tag: package-2020-05-01-preview and go

These settings apply only when `--tag=package-2020-05-01-preview --python` is specified on the command line.

```yaml $(python)
python:
  namespace: azure.mgmt.azureadb2c.v2020_05_01
  output-folder: $(python-sdks-folder)/azureadb2c/azure-mgmt-azureadb2c/azure/mgmt/azureadb2c/v2020_05_01
```
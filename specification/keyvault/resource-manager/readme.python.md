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
  package-name: azure-mgmt-keyvault
  clear-output-folder: true
  no-namespace-folders: true
```

### Python multi-api

Generate all API versions currently shipped for this package

```yaml $(python) && $(multiapi)
batch:
  - tag: package-2019-09
  - tag: package-2018-02
  - tag: package-2016-10
```

### Tag: package-2019-09 and python

These settings apply only when `--tag=package-2019-09 --python` is specified on the command line.

``` yaml $(tag) == 'package-2019-09' && $(python)
python:
  namespace: azure.mgmt.keyvault.v2019_09_01
  output-folder: $(python-sdks-folder)/keyvault/azure-mgmt-keyvault/azure/mgmt/keyvault/v2019_09_01
```

### Tag: package-2018-02 and python

These settings apply only when `--tag=package-2018-02 --python` is specified on the command line.

``` yaml $(tag) == 'package-2018-02' && $(python)
python:
  namespace: azure.mgmt.keyvault.v2018_02_14
  output-folder: $(python-sdks-folder)/keyvault/azure-mgmt-keyvault/azure/mgmt/keyvault/v2018_02_14
```

### Tag: package-2016-10 and python

These settings apply only when `--tag=package-2016-10 --python` is specified on the command line.

``` yaml $(tag) == 'package-2016-10' && $(python)
python:
  namespace: azure.mgmt.keyvault.v2016_10_01
  output-folder: $(python-sdks-folder/keyvault)/azure-mgmt-keyvault/azure/mgmt/keyvault/v2016_10_01
```

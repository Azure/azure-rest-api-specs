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
  package-name: azure-mgmt-web
  package-version: 0.42.0
  clear-output-folder: true
  no-namespace-folders: true
```

### Python multi-api

Generate all API versions currently shipped for this package

```yaml $(python) && $(multiapi)
batch:
  - tag: package-2019-08-only
  - tag: package-2018-11-only
  - tag: package-2018-02-only
  - tag: package-2016-09-only
  - tag: package-2016-08-only
  - tag: package-2016-03-only
  - tag: package-2015-08-only
  - tag: package-2015-04-only
```

### Tag: package-2019-08-only and python

These settings apply only when `--tag=package-2019-08-only --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-2019-08-only' && $(python)
python:
  namespace: azure.mgmt.web.v2019_08_01
  output-folder: $(python-sdks-folder)/appservice/azure-mgmt-web/azure/mgmt/web/v2019_08_01
```

### Tag: package-2018-11-only and python

These settings apply only when `--tag=package-2018-11-only --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-2018-11-only' && $(python)
python:
  namespace: azure.mgmt.web.v2018_11_01
  output-folder: $(python-sdks-folder)/appservice/azure-mgmt-web/azure/mgmt/web/v2018_11_01
```

### Tag: package-2018-02-only and python

These settings apply only when `--tag=package-2018-02-only --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-2018-02-only' && $(python)
python:
  namespace: azure.mgmt.web.v2018_02_01
  output-folder: $(python-sdks-folder)/appservice/azure-mgmt-web/azure/mgmt/web/v2018_02_01
```

### Tag: package-2016-09-only and python

These settings apply only when `--tag=package-2016-09-only --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-2016-09-only' && $(python)
python:
  namespace: azure.mgmt.web.v2016_09_01
  output-folder: $(python-sdks-folder)/appservice/azure-mgmt-web/azure/mgmt/web/v2016_09_01
```

### Tag: package-2016-08-only and python

These settings apply only when `--tag=package-2016-08-only --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-2016-08-only' && $(python)
python:
  namespace: azure.mgmt.web.v2016_08_01
  output-folder: $(python-sdks-folder)/appservice/azure-mgmt-web/azure/mgmt/web/v2016_08_01
```

### Tag: package-2016-03-only and python

These settings apply only when `--tag=package-2016-03-only --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-2016-03-only' && $(python)
python:
  namespace: azure.mgmt.web.v2016_03_01
  output-folder: $(python-sdks-folder)/appservice/azure-mgmt-web/azure/mgmt/web/v2016_03_01
```

### Tag: package-2015-08-only and python

These settings apply only when `--tag=package-2019-04-only --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-2015-08-only' && $(python)
python:
  namespace: azure.mgmt.web.v2015_08_01
  output-folder: $(python-sdks-folder)/appservice/azure-mgmt-web/azure/mgmt/web/v2015_08_01
```

### Tag: package-2015-04-only and python

These settings apply only when `--tag=package-2019-04-only --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-2015-04-only' && $(python)
python:
  namespace: azure.mgmt.web.v2015_04_01
  output-folder: $(python-sdks-folder)/appservice/azure-mgmt-web/azure/mgmt/web/v2015_04_01
```

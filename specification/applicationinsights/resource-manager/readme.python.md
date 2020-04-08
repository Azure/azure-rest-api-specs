## Python

## python
These settings apply only when `--python` is specified on the command line.

```yaml $(python)
python-mode: create
python:
  azure-arm: true
  license-header: MICROSOFT_MIT_NO_VERSION
  payload-flattening-threshold: 2
  package-name: azure-mgmt-applicationinsights
  clear-output-folder: true
  no-namespace-folders: true
```
### Python multi-api

``` yaml $(python) && $(multiapi)
batch:
  - tag: package-2015-05
  - tag: package-2017-10
  - tag: package-2018-05-01-preview
  - tag: package-2018-06-17-preview
  - tag: package-2019-09-01-preview
  - tag: package-2019-10-17-preview
  - tag: package-2020-02-02-preview
  - tag: package-2020-03-01-preview
```

### Tag: package-2015-05 and python

These settings apply only when `--tag=package-2015-05 --python` is specified on the command line.

``` yaml $(tag) == 'package-2015-05' && $(python)
python:
  namespace: azure.mgmt.applicationinsights.v2015_05_01
  output-folder: $(python-sdks-folder)/applicationinsights/azure-mgmt-applicationinsights/azure/mgmt/applicationinsights/v2015_05_01
```

### Tag: package-2017-10 and python

These settings apply only when `--tag=package-2017-10 --python` is specified on the command line.

``` yaml $(tag) == 'package-2017-10' && $(python)
python:
  namespace: azure.mgmt.applicationinsights.v2017_10_01
  output-folder: $(python-sdks-folder)/applicationinsights/azure-mgmt-applicationinsights/azure/mgmt/applicationinsights/v2017_10_01
```

### Tag: package-2018-06-17-preview and python

These settings apply only when `--tag=package-2018-06-17-preview --python` is specified on the command line.

``` yaml $(tag) == 'package-2018-06-17-preview' && $(python)
python:
  namespace: azure.mgmt.applicationinsights.v2018_06_17_preview
  output-folder: $(python-sdks-folder)/applicationinsights/azure-mgmt-applicationinsights/azure/mgmt/applicationinsights/v2018_06_17_preview
```

### Tag: package-2019-10-17-preview and python

These settings apply only when `--tag=package-2019-10-17-preview --python` is specified on the command line.

```yaml $(tag) == 'package-2019-10-17-preview' && $(python)
python:
  namespace: azure.mgmt.applicationinsights.v2019_10_17_preview
  output-folder: $(python-sdks-folder)/applicationinsights/azure-mgmt-applicationinsights/azure/mgmt/applicationinsights/v2019_10_17_preview
```

### Tag: package-2018-05-01-preview and python

These settings apply only when `--tag=package-2018-05-01-preview --python` is specified on the command line.

``` yaml $(tag) == 'package-2018-05-01-preview' && $(python)
python:
  namespace: azure.mgmt.applicationinsights.v2018_05_01_preview
  output-folder: $(python-sdks-folder)/applicationinsights/azure-mgmt-applicationinsights/azure/mgmt/applicationinsights/v2018_05_01_preview
```

### Tag: package-2019-09-01-preview and python

These settings apply only when `--tag=package-2019-09-01-preview --python` is specified on the command line.

``` yaml $(tag) == 'package-2019-09-01-preview' && $(python)
python:
  namespace: azure.mgmt.applicationinsights.v2019_09_01_preview
  output-folder: $(python-sdks-folder)/applicationinsights/azure-mgmt-applicationinsights/azure/mgmt/applicationinsights/v2019_09_01_preview
```

### Tag: package-2020-02-02-preview and python

These settings apply only when `--tag=package-2020-02-02-preview --python` is specified on the command line.

``` yaml $(tag) == 'package-2020-02-02-preview' && $(python)
python:
  namespace: azure.mgmt.applicationinsights.v2020_02_02_preview
  output-folder: $(python-sdks-folder)/applicationinsights/azure-mgmt-applicationinsights/azure/mgmt/applicationinsights/v2020_02_02_preview
```

### Tag: package-2020-03-01-preview and python

These settings apply only when `--tag=package-2020-03-01-preview --python` is specified on the command line.

``` yaml $(tag) == 'package-2020-03-01-preview' && $(python)
python:
  namespace: azure.mgmt.applicationinsights.v2020_03_01_preview
  output-folder: $(python-sdks-folder)/applicationinsights/azure-mgmt-applicationinsights/azure/mgmt/applicationinsights/v2020_03_01_preview
```




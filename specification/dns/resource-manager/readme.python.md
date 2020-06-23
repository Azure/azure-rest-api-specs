## Python

These settings apply only when `--python` is specified on the command line.

```yaml $(python)
python:
  azure-arm: true
  license-header: MICROSOFT_MIT_NO_VERSION
  payload-flattening-threshold: 2
  package-name: azure-mgmt-dns
  clear-output-folder: true
  no-namespace-folders: true
```

### Python multi-api

Generate all API versions currently shipped for this package

```yaml $(python) && $(multiapi)
batch:
  - tag: package-2018-05
  - tag: package-2018-03-preview
  - tag: package-2016-04
```

### Tag: package-2018-05 and python

These settings apply only when `--tag=package-2018-05 --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-2018-05' && $(python)
python:
  namespace: azure.mgmt.dns.v2018_05_01
  output-folder: $(python-sdks-folder)/network/azure-mgmt-dns/azure/mgmt/dns/v2018_05_01
```

### Tag: package-2018-03-preview and python

These settings apply only when `--tag=package-2018-03-preview --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-2018-03-preview' && $(python)
python:
  namespace: azure.mgmt.dns.v2018_03_01_preview
  output-folder: $(python-sdks-folder)/network/azure-mgmt-dns/azure/mgmt/dns/v2018_03_01_preview
```

### Tag: package-2016-04 and python

These settings apply only when `--tag=package-2016-04 --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-2016-04' && $(python)
python:
  namespace: azure.mgmt.dns.v2016_04_01
  output-folder: $(python-sdks-folder)/network/azure-mgmt-dns/azure/mgmt/dns/v2016_04_01
```

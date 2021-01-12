## Python

These settings apply only when `--python` is specified on the command line.

```yaml $(python) && !$(track2)
python:
  azure-arm: true
  license-header: MICROSOFT_MIT_NO_VERSION
  payload-flattening-threshold: 2
  package-name: azure-mgmt-redhatopenshift
  clear-output-folder: true
  no-namespace-folders: true
```
```yaml $(python) && $(track2)
azure-arm: true
license-header: MICROSOFT_MIT_NO_VERSION
package-name: azure-mgmt-redhatopenshift
clear-output-folder: true
no-namespace-folders: true
```

### Python multi-api

Generate all API versions currently shipped for this package

```yaml $(python) && $(multiapi) && !$(track2)
batch:
  - tag: package-2020-04-30
  - tag: package-2021-01-31-preview
```
```yaml $(python) && $(multiapi) && $(track2)
batch:
  - tag: package-2020-04-30
  - tag: package-2021-01-31-preview
  - multiapiscript: true
```

``` yaml $(multiapiscript)
output-folder: $(python-sdks-folder)/redhatopenshift/azure-mgmt-redhatopenshift/azure/mgmt/redhatopenshift/
clear-output-folder: false
perform-load: false
```

### Tag: package-2020-04-30 and python

These settings apply only when `--tag=package-2020-04-30 --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-2020-04-30' && $(python) && !$(track2)
python:
  namespace: azure.mgmt.redhatopenshift.v2020_04_30
  output-folder: $(python-sdks-folder)/redhatopenshift/azure-mgmt-redhatopenshift/azure/mgmt/redhatopenshift/v2020_04_30
```

``` yaml $(tag) == 'package-2020-04-30' && $(python) && $(track2)
namespace: azure.mgmt.redhatopenshift.v2020_04_30
output-folder: $(python-sdks-folder)/redhatopenshift/azure-mgmt-redhatopenshift/azure/mgmt/redhatopenshift/v2020_04_30
```

### Tag: package-2021-01-31-preview and python

These settings apply only when `--tag=package-2021-01-31-preview --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-2021-01-31-preview' && $(python) && !$(track2)
python:
  namespace: azure.mgmt.redhatopenshift.v2021-01-31-preview
  output-folder: $(python-sdks-folder)/redhatopenshift/azure-mgmt-redhatopenshift/azure/mgmt/redhatopenshift/v2021-01-31-preview
```

``` yaml $(tag) == 'package-2021-01-31-preview' && $(python) && $(track2)
namespace: azure.mgmt.redhatopenshift.v2021-01-31-preview
output-folder: $(python-sdks-folder)/redhatopenshift/azure-mgmt-redhatopenshift/azure/mgmt/redhatopenshift/v2021-01-31-preview
```


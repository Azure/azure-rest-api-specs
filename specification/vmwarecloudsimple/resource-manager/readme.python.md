## Python

These settings apply only when `--python` is specified on the command line.

```yaml $(python)
python:
  azure-arm: true
  license-header: MICROSOFT_MIT_NO_VERSION
  payload-flattening-threshold: 2
  package-name: azure-mgmt-vmwarecloudsimple
  clear-output-folder: true
  no-namespace-folders: true
```

### Python multi-api

Generate all API versions currently shipped for this package

```yaml $(python) && $(multiapi)
batch:
  - tag: package-2019-04-01
 ```

### Tag: package-2019-04-01 and python

These settings apply only when `--tag=package-2019-04-01 --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-2019-04-01' && $(python)
python:
  namespace: azure.mgmt.vmwarecloudsimple.v2019_04_01
  output-folder: $(python-sdks-folder)/azure-mgmt-vmwarecloudsimple/azure/mgmt/vmwarecloudsimple/v2019_04_01
```

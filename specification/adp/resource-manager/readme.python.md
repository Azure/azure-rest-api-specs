## Python

These settings apply only when `--python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

```yaml $(python)
python:
  azure-arm: true
  license-header: MICROSOFT_MIT_NO_VERSION
  payload-flattening-threshold: 2
  package-name: adp
  clear-output-folder: true
  no-namespace-folders: true
```

```yaml $(multiapi)
clear-output-folder: true
batch:
  - tag: package-2020-07-01-preview
  - multiapiscript: true
```

``` yaml $(multiapiscript)
output-folder: $(python-sdks-folder)/adp/azure-mgmt-adp/azure/mgmt/adp/
clear-output-folder: false
perform-load: false
```

``` yaml $(tag) == 'package-2020-07-01-preview'
namespace: azure.mgmt.adp.v2020_07_01_preview
output-folder: $(python-sdks-folder)/adp/azure-mgmt-adp/azure/mgmt/adp/v2020_07_01_preview
python:
  namespace: azure.mgmt.adp.v2020_07_01_preview
  output-folder: $(python-sdks-folder)/adp/azure-mgmt-adp/azure/mgmt/adp/v2020_07_01_preview
```

## Python

These settings apply only when `--python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.


These settings apply only when `--python` is specified on the command line.

``` yaml !$(track2)
python:
  azure-arm: true
  license-header: MICROSOFT_MIT_NO_VERSION
  payload-flattening-threshold: 2
  package-name: azure-mgmt-vmwareapplication
  clear-output-folder: true
  no-namespace-folders: true
```

These settings apply only when `--track2` is specified on the command line.

``` yaml $(track2)
azure-arm: true
license-header: MICROSOFT_MIT_NO_VERSION
package-name: azure-mgmt-vmwareapplication
no-namespace-folders: true
```

### Python multi-api

Generate all API versions currently shipped for this package

```yaml $(multiapi) && !$(track2)
batch:
  - tag: package-vmwareapplications-2021-02
```

```yaml $(multiapi) && $(track2)
clear-output-folder: true
batch:
  - tag: package-vmwareapplications-2021-02
  - multiapiscript: true
```

``` yaml $(multiapiscript)
output-folder: $(python-sdks-folder)/vmwareapplication/azure-mgmt-vmwareapplication/azure/mgmt/vmwareapplication/
clear-output-folder: false
perform-load: false
```

### Tag: package-vmwareapplications-2021-02 and python

These settings apply only when `--tag=package-vmwareapplications-2021-02 --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-vmwareapplications-2021-02'
namespace: azure.mgmt.vmwareapplication.v2021_02_01_preview
output-folder: $(python-sdks-folder)/vmwareapplication/azure-mgmt-vmwareapplication/azure/mgmt/vmwareapplication/v2021_02_01_preview
python:
  namespace: azure.mgmt.vmwareapplication.v2021_02_01_preview
  output-folder: $(python-sdks-folder)/vmwareapplication/azure-mgmt-vmwareapplication/azure/mgmt/vmwareapplication/v2021_02_01_preview
```
## Python

These settings apply only when `--python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

```yaml $(python) && !$(track2)
python-mode: create
python:
  azure-arm: true
  license-header: MICROSOFT_MIT_NO_VERSION
  payload-flattening-threshold: 2
  namespace: azure.mgmt.healthbot
  package-name: azure-mgmt-healthbot
  package-version: 2020-12-08
  clear-output-folder: true
```
```yaml $(python) && $(track2)
azure-arm: true
license-header: MICROSOFT_MIT_NO_VERSION
payload-flattening-threshold: 2
namespace: azure.mgmt.healthbot
package-name: azure-mgmt-healthbot
package-version: 2020-12-08
clear-output-folder: true
```

``` yaml $(python) && $(python-mode) == 'update'
python:
    no-namespace-folders: true
    output-folder: $(python-sdks-folder)/{svcName}/azure-mgmt-healthbot/azure/mgmt/healthbot
```
``` yaml $(python) && $(python-mode) == 'create'
python:
    basic-setup-py: true
    output-folder: $(python-sdks-folder)/healthbot/azure-mgmt-healthbot
```

``` yaml $(python-mode) == 'update' && $(track2)
output-folder: $(python-sdks-folder)/healthbot/azure-mgmt-healthbot/azure/mgmt/healthbot
```
``` yaml $(python-mode) == 'create' && $(track2)
basic-setup-py: true
output-folder: $(python-sdks-folder)/healthbot/azure-mgmt-healthbot
```
